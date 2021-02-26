# frozen_string_literal: true

require "json"
require "stringio"

class Fisk
  X86_64 = JSON.load_file File.join(File.dirname(__FILE__), "json-x86-64/x86_64.json")

  module Registers
    class Register < Struct.new(:name, :type, :value)
      def works? type
        type == self.name || type == self.type
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
  end

  class Operand < Struct.new(:value)
    def type; value; end
    def works? type; self.type == type; end
  end

  class Imm32 < Operand
    def type
      "imm32"
    end
  end

  class Imm8 < Operand
    def type
      "imm8"
    end
  end

  class Lit < Operand; end

  def initialize
    @instructions = []
  end

  Registers.constants.grep(/^[A-Z0-9]*$/).each do |const|
    val = Registers.const_get const
    define_method(const.downcase) { val }
  end

  class Instruction
    def initialize insn, operands
      @insn     = insn
      @operands = operands
    end

    def encode buffer
      encoding = @insn["encodings"].first

      encoding.each do |type, info|
        case type
        when "opcode" then
          byte = info["byte"].to_i(16)

          if info["addend"]
            byte |= get_operand_value(info["addend"])
          end

          buffer.putc byte
        when "immediate"
          value = get_operand_value(info["value"])
          write_num buffer, value, info["size"]
        when "ModRM"
          mode = info["mode"].to_i(2)
          reg = get_operand_value(info["reg"]) & 0x7
          rm = get_operand_value(info["rm"]) & 0x7
          buffer.putc ((mode << 6) | (reg << 3) | rm)
        when "REX"
          next if info["mandatory"] == false
          rex = 0b0100
          rex = (rex << 1) | check_rex(info["W"], @operands)
          rex = (rex << 1) | check_rex(info["R"], @operands)
          rex = (rex << 1) | check_rex(info["X"], @operands)
          rex = (rex << 1) | check_rex(info["B"], @operands)
          buffer.putc rex
        else
          raise NotImplementedError, "unknown type #{type}"
        end
      end
    end

    private

    def write_num buffer, num, size
      size.times {
        buffer.putc(num & 0xFF)
        num >>= 8
      }
    end

    def get_operand_value v
      case v
      when /^#(\d+)$/
        @operands[$1.to_i].value
      when /^(\d+)$/
        $1.to_i
      else
        raise NotImplementedError
      end
    end

    def check_rex v, operands
      return 0 unless v

      case v
      when /^(\d+)$/
        v.to_i
      when /^#(\d+)$/
        (operands[$1.to_i].value >> 3)
      else
        raise NotImplementedError, v
      end
    end
  end

  def gen name, params
    possibles = X86_64["instructions"][name]["forms"].find_all do |insn|
      if (insn["operands"] || []).length == params.length
        params.zip((insn["operands"] || [])).all? { |want_op, have_op|
          want_op.works?(have_op["type"])
        }
      else
        false
      end
    end

    raise NotImplementedError, "couldn't find instruction" if possibles.length == 0

    insn = nil

    if possibles.length > 1
      # pick the shortest instruction
      possibles = possibles.sort_by { |thing| thing["encodings"].first.size }
    end

    insn = possibles.first

    @instructions << Instruction.new(insn, params)
    self
  end

  X86_64["instructions"].keys.each do |insn|
    define_method(insn.downcase) do |*params|
      gen insn, params
    end
  end

  def imm32 val
    Imm32.new val
  end

  def imm8 val
    Imm8.new val
  end

  def lit val
    # to_s because we're getting the value from JSON as a string
    Lit.new val.to_s
  end

  def asm buf = StringIO.new(''.b), &block
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
