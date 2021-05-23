# frozen_string_literal: true

require "fisk/machine/encoding"
require "fisk/machine"

class Fisk
  module Registers
    class Register < Struct.new(:name, :type, :value)
      def works? type
        type == self.name || type == self.type
      end

      def unknown_label?; false; end
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

  class Operand < Struct.new(:value)
    def type; value; end
    def works? type; self.type == type; end
    def unknown_label?; false; end
  end

  class Imm8 < Operand
    def type
      "imm8"
    end
  end

  class Imm32 < Operand
    def type
      "imm32"
    end
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
    @position = 0
  end

  class UnknownLabel < Struct.new(:name, :assembler, :insn)
    def works? type
      type == "rel32"
    end

    def unknown_label?; true; end

    def value
      label = assembler.label_for(name)
      label.position - (insn.position + insn.bytesize)
    end
  end

  class Label < Struct.new(:name, :position)
  end

  def label_for name
    @labels.fetch name
  end

  def label name
    UnknownLabel.new(name, self)
  end

  def make_label name
    @labels[name] = Label.new(name, position)
  end

  Registers.constants.grep(/^[A-Z0-9]*$/).each do |const|
    val = Registers.const_get const
    define_method(const.downcase) { val }
  end

  class Instruction
    attr_reader :position

    def initialize insn, operands, position
      @insn     = insn
      @operands = operands
      @position = position
    end

    def encodings
      @insn.encodings
    end

    def encode buffer
      encoding = @insn.encodings.first
      encoding.encode buffer, @operands
    end

    def bytesize
      @insn.encodings.first.bytesize
    end
  end

  def gen name, params
    insns = Machine.instruction_with_name(name)
    forms = insns.forms.find_all do |insn|
      if insn.operands.length == params.length
        params.zip(insn.operands).all? { |want_op, have_op|
          want_op.works?(have_op.type)
        }
      else
        false
      end
    end

    raise NotImplementedError, "couldn't find instruction #{name}" if forms.length == 0

    insn = nil

    insn = forms.first

    insn = Instruction.new(insn, params, position)
    @position += insn.bytesize
    @instructions << insn
    params.each { |param| param.insn = insn if param.unknown_label? }

    self
  end

  Machine.instructions.keys.each do |insn|
    define_method(insn.downcase) do |*params|
      gen insn, params
    end
  end

  def moffs64 val
    MOffs64.new val
  end

  def imm8 val
    Imm8.new val
  end

  def imm32 val
    Imm32.new val
  end

  def rel8 val
    Rel8.new val
  end

  def rel32 val
    Rel32.new val
  end

  def lit val
    # to_s because we're getting the value from JSON as a string
    Lit.new val
  end

  def asm buf = StringIO.new(''.b), &block
    @position = 0
    instance_eval(&block)
    write_to_buffer buf
    buf
  end

  def to_binary
    io = StringIO.new ''.b
    write_to_buffer io
    io.string
  end

  private

  def write_to_buffer buffer
    @instructions.each { |insn| insn.encode buffer }
  end
end
