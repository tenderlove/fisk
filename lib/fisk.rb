# frozen_string_literal: true

require "stringio"
require "fisk/instructions"

class Fisk
  class Operand < Struct.new(:value)
    def type; value; end
    def works? type; self.type == type; end
    def unknown_label?; false; end
    def extended_register?; false; end
    def m64?; false; end
  end

  module Registers
    class Register < Operand
      attr_reader :name, :type

      def initialize name, type, value
        @name = name
        @type = type
        super(value)
      end

      def works? type
        type == self.name || type == self.type
      end

      def extended_register?; value > 7; end
    end

    EAX = Register.new "eax", "r32", 0
    ECX = Register.new "ecx", "r32", 1
    EDX = Register.new "edx", "r32", 2
    EBX = Register.new "ebx", "r32", 3
    ESP = Register.new "esp", "r32", 4
    EBP = Register.new "ebp", "r32", 5
    ESI = Register.new "esi", "r32", 6
    EDI = Register.new "edi", "r32", 7

    RAX = Register.new "rax", "r64", 0
    RCX = Register.new "rcx", "r64", 1
    RDX = Register.new "rdx", "r64", 2
    RBX = Register.new "rbx", "r64", 3
    RSP = Register.new "rsp", "r64", 4
    RBP = Register.new "rbp", "r64", 5
    RSI = Register.new "rsi", "r64", 6
    RDI = Register.new "rdi", "r64", 7
    8.times do |i|
      i += 8
      const_set "R#{i}", Register.new("r#{i}", "r64", i)
    end
  end


  class M64 < Operand
    attr_reader :displacement

    def initialize register, displacement
      super(register.value)
      @register     = register
      @displacement = displacement
    end

    def type
      "m64"
    end

    def m64?; true; end
  end

  def m64 x, displacement = 0
    M64.new x, displacement
  end

  # Define all immediate value methods of different sizes
  [8, 16, 32, 64].each do |size|
    class_eval <<~eostr, __FILE__, __LINE__ + 1
      class Imm#{size} < Operand
        def type
          "imm#{size}"
        end
      end

      def imm#{size} val; Imm#{size}.new(val.to_i); end
    eostr
  end

  class Rel8 < Operand
    def type
      "rel8"
    end
  end

  class Rel32 < Operand
    def type
      "rel32"
    end
  end

  class MOffs64 < Operand
    def type
      "moffs64"
    end
  end

  class Lit < Operand
    def type
      value.to_s
    end
  end

  attr_reader :position

  def initialize
    @instructions = []
    @labels = {}
    yield self if block_given?
  end

  class UnknownLabel < Struct.new(:name)
    def works? type
      type == "rel32"
    end

    def unknown_label?; true; end

    def value
      label = assembler.label_for(name)
      label.position - (insn.position + insn.bytesize)
    end
  end

  class Label < Struct.new(:name)
    def label?; true; end
  end

  # Create a label to be used with jump instructions.  For example:
  #
  #   fisk.jmp(fisk.label(:foo))
  #   fisk.int(lit(3))
  #   fisk.make_label(:foo)
  #
  def label name
    UnknownLabel.new(name)
  end

  # Insert a label named +name+ at the current position in the instructions.
  def put_label name
    @instructions << Label.new(name)
    self
  end

  Registers.constants.grep(/^[A-Z0-9]*$/).each do |const|
    val = Registers.const_get const
    define_method(const.downcase) { val }
  end

  class Instruction
    def initialize insn, form, operands
      @insn     = insn
      @form     = form
      @operands = operands
    end

    def encodings
      @form.encodings
    end

    def encode buffer, labels
      encoding = @form.encodings.first
      encoding.encode buffer, @operands
      true
    end

    def bytesize
      @form.encodings.first.bytesize
    end

    def label?; false; end
  end

  class UnresolvedInstruction
    def initialize insn, form, operand
      @insn      = insn
      @form      = form
      @operand   = operand
      @saved_pos = nil
    end

    def encode buffer, labels
      # Estimate by using a rel32 offset
      form          = find_form "rel32"
      encoding      = form.encodings.first
      operand_klass = Rel32

      if labels.key? @operand.name
        if @saved_pos
          # Only use rel32 if we saved the position
          buffer.seek @saved_pos, IO::SEEK_SET
        else
          estimated_offset = labels[@operand.name] - (buffer.pos + encoding.bytesize)

          if estimated_offset >= -128 && estimated_offset <= 127
            # fits in a rel8
            operand_klass = Rel8
            form          = find_form "rel8"
            encoding      = form.encodings.first
          end
        end

        jump_len = -(buffer.pos + encoding.bytesize - labels[@operand.name])
        encoding.encode buffer, [operand_klass.new(jump_len)]
        true
      else
        # We've hit a label that doesn't exist yet
        # Save the buffer position so we can seek back to it later
        @saved_pos = buffer.pos
        # Write 5 bytes to reserve our spot
        encoding.bytesize.times { buffer.putc 0 }
        false
      end
    end

    def label?; false; end

    private

    def find_form form_type
      @insn.forms.find { |form| form.operands.first.type == form_type }
    end
  end

  include Fisk::Instructions::DSLMethods

  def moffs64 val
    MOffs64.new val
  end

  # Create a signed immediate value of the right width
  def imm val
    if val >= -0x7F - 1 && val <= 0x7F
      imm8 val
    elsif val >=  -0x7FFF - 1 && val <= 0x7FFF
      imm16 val
    elsif val >=  -0x7FFFFFFF - 1 && val <= 0x7FFFFFFF
      imm32 val
    elsif val >=  -0x7FFFFFFFFFFFFFFF - 1 && val <= 0x7FFFFFFFFFFFFFFF
      imm64 val
    else
      raise ArgumentError, "#{val} is larger than a 64 bit int"
    end
  end

  # Create an unsigned immediate value of the right width
  def uimm val
    if val < 0
      raise ArgumentError, "#{val} is negative"
    elsif val <= 0xFF
      imm8 val
    elsif val <= 0xFFFF
      imm16 val
    elsif val <= 0xFFFFFFFF
      imm32 val
    elsif val <= 0xFFFFFFFFFFFFFFFF
      imm64 val
    else
      raise ArgumentError, "#{val} is too large for a 64 bit int"
    end
  end

  def rel8 val
    Rel8.new val
  end

  def rel32 val
    Rel32.new val
  end

  def lit val
    Lit.new val
  end

  def asm buf = StringIO.new(''.b), &block
    instance_eval(&block)
    write_to buf
    buf
  end

  def to_binary
    io = StringIO.new ''.b
    write_to io
    io.string
  end

  def write_to buffer
    labels = {}
    unresolved = []
    @instructions.each do |insn|
      if insn.label?
        labels[insn.name] = buffer.pos
      else
        unless insn.encode buffer, labels
          unresolved << insn
        end
      end
    end

    return if unresolved.empty?

    pos = buffer.pos
    unresolved.each do |insn|
      insn.encode buffer, labels
    end
    buffer.seek pos, IO::SEEK_SET

    buffer
  end

  def gen_with_insn insns, params
    forms = insns.forms.find_all do |insn|
      if insn.operands.length == params.length
        params.zip(insn.operands).all? { |want_op, have_op|
          want_op.works?(have_op.type)
        }
      else
        false
      end
    end

    if forms.length == 0
      valid_forms = insns.forms.map { |form|
        "    #{insns.name} #{form.operands.map(&:type).join(", ")}"
      }.join "\n"
      msg = <<~eostr
      Couldn't find instruction #{insns.name} #{params.map(&:type).join(", ")}
      Valid forms:
      #{valid_forms}
      eostr
      raise NotImplementedError, msg
    end

    insn = nil

    form = forms.first

    insn = if params.any?(&:unknown_label?)
             if params.length > 1
               raise ArgumentError, "labels only work with single param jump instructions"
             end
             UnresolvedInstruction.new(insns, form, params.first)
           else
             Instruction.new(insns, form, params)
           end
    @instructions << insn

    self
  end
end
