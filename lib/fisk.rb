# frozen_string_literal: true

require "stringio"
require "fisk/instructions"
require "fisk/basic_block"
require "set"

class Fisk
  class Operand
    def works? type; self.type == type; end
    def unknown_label?; false; end
    def register?; false; end
    def temp_register?; false; end
    def extended_register?; false; end
    def m64?; false; end

    def rex_value
      value >> 3
    end

    def op_value
      value
    end
  end

  class ValueOperand < Operand
    attr_reader :value
    alias :type :value

    def initialize value
      @value = value
    end
  end

  module Registers
    class Register < Operand
      attr_reader :name, :type, :value

      def initialize name, type, value
        @name = name
        @type = type
        @value = value
      end

      def works? type
        type == self.name || type == self.type
      end

      def op_value
        value & 0x7
      end

      def extended_register?; @value > 7; end
    end

    class Temp < Operand
      attr_reader :name, :type
      attr_accessor :register, :start_point, :end_point

      def initialize name, type
        @name        = name
        @type        = type
        @start_point = nil
        @end_point   = nil
      end

      def temp_register?; true; end

      def extended_register?
        @register.extended_register?
      end

      def rex_value
        @register.rex_value
      end

      def value
        @register.value
      end
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

    # List of *caller* saved registers for the C calling convention
    CALLER_SAVED = [ RDI, RSI, RDX, RCX, R8, R9, R10, R11 ]

    # List of *callee* saved registers for the C calling convention
    CALLEE_SAVED = [ RBX, RSP, RBP, R12, R13, R14, R15 ]
  end


  class M64 < Operand
    attr_reader :displacement

    def initialize register, displacement
      @register     = register
      @displacement = displacement
    end

    def value
      @register.value
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
      class Imm#{size} < ValueOperand
        def type
          "imm#{size}"
        end
      end

      def imm#{size} val; Imm#{size}.new(val.to_i); end
    eostr
  end

  class Rel8 < ValueOperand
    def type
      "rel8"
    end
  end

  class Rel32 < ValueOperand
    def type
      "rel32"
    end
  end

  class MOffs64 < ValueOperand
    def type
      "moffs64"
    end
  end

  class Lit < ValueOperand
    def type
      value.to_s
    end
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
    def jump?; false; end
    def has_temp_registers?; false; end
  end

  class Instruction
    def initialize insn, form, operands
      @insn     = insn
      @form     = form
      @operands = operands
    end

    def jump?
      false
    end

    def has_temp_registers?
      @operands.any?(&:temp_register?)
    end

    def temp_registers
      @operands.find_all(&:temp_register?)
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

    def jump?
      true
    end

    def target
      @operand.name
    end

    def has_temp_registers?; false; end

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

  def initialize
    @instructions = []
    @labels = {}
    yield self if block_given?
  end

  # Return a list of basic blocks for the instructions
  def basic_blocks
    cfg.blocks
  end

  # Return a cfg for these instructions.  The CFG includes connected basic
  # blocks as well as any temporary registers
  def cfg
    CFG.build @instructions
  end

  # Create a label to be used with jump instructions.  For example:
  #
  #   fisk.jmp(fisk.label(:foo))
  #   fisk.int(lit(3))
  #   fisk.put_label(:foo)
  #
  def label name
    UnknownLabel.new(name)
  end

  # Insert a label named +name+ at the current position in the instructions.
  def put_label name
    @instructions << Label.new(name)
    self
  end
  alias :make_label :put_label

  # Allocate and return a new register.  These registers will be replaced with
  # real registers when `assign_registers` is called.
  def register name = "temp"
    Registers::Temp.new name, "r64"
  end

  # Assign registers to any temporary registers.  Only registers in +list+
  # will be used when selecting register assignments
  def assign_registers list
    cfg = self.cfg
    temp_registers = cfg.variables
    temp_registers = temp_registers.sort_by(&:start_point)

    active         = []
    free_registers = list.reverse
    register_count = list.length

    temp_registers.each do |temp_reg|
      # expire old intervals
      active, dead = active.sort_by(&:end_point).partition do |j|
        j.end_point >= temp_reg.start_point
      end

      # Add unused registers back to the free register list
      dead.each { |tr| free_registers << tr.register }

      if active.length == register_count
        raise NotImplementedError, "Register spilled"
      end

      temp_reg.register = free_registers.pop
      active << temp_reg
    end
  end

  Registers.constants.grep(/^[A-Z0-9]*$/).each do |const|
    val = Registers.const_get const
    define_method(const.downcase) { val }
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

  # Instance eval's a given block and writes encoded instructions to +buf+.
  # For example:
  #
  #   fisk = Fisk.new
  #   fisk.asm do
  #     mov r9, imm64(32)
  #   end
  #
  def asm buf = StringIO.new(''.b), &block
    instance_eval(&block)
    write_to buf
    buf
  end

  # Encodes all instructions and returns a binary string with the encoded
  # instructions.
  def to_binary
    io = StringIO.new ''.b
    write_to io
    io.string
  end

  # Encode all instructions and write them to +buffer+.  +buffer+ should be an
  # IO object.
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
