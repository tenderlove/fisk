require "json"

class Fisk
  X86_64 = JSON.load_file File.join(File.dirname(__FILE__), "x86_64.json")

  module Registers
    class Register < Struct.new(:name, :type, :value)
    end

    EAX = Register.new :eax, "eax", 0
    ECX = Register.new :ecx, "r32", 1
    ESI = Register.new :esi, "r32", 6

    RAX = Register.new :rax, "rax", 0
    RCX = Register.new :rcx, "r64", 1
    RDX = Register.new :rdx, "r64", 2
    RBX = Register.new :rbx, "r64", 3
    RSP = Register.new :rsp, "r64", 4
    RBP = Register.new :rbp, "r64", 5
    RSI = Register.new :rsi, "r64", 6
    RDI = Register.new :rdi, "r64", 7
  end

  module Instructions
    class Instruction
      attr_reader :value, :mnemonic

      def initialize value, mnemonic
        @value    = value
        @mnemonic = mnemonic
      end

      def compile operands
        [value, operands.op2.value].pack("Cl<")
      end
    end

    Add = Instruction.new 0x05, "ADD"
  end

  class Imm32 < Struct.new(:value)
    def type
      "imm32"
    end
  end

  def initialize
    @instructions = []
  end

  def eax; Registers::EAX; end
  def ecx; Registers::ECX; end
  def esi; Registers::ESI; end

  def rax; Registers::RAX; end
  def rcx; Registers::RCX; end
  def rdx; Registers::RDX; end
  def rbx; Registers::RBX; end
  def rsp; Registers::RSP; end
  def rbp; Registers::RBP; end
  def rsi; Registers::RSI; end
  def rdi; Registers::RDI; end

  class Instruction
    def initialize insn, operands
      @insn     = insn
      @operands = operands
    end

    def encode
      #if @insn["encodings"].length > 1
      #  raise NotImplementedError
      #end

      encoding = @insn["encodings"].first

      buf = []
      pattern = ""
      encoding.each do |type, info|
        case type
        when "prefix" then
        when "opcode" then
          buf << info["byte"].to_i(16)
          pattern << "C"
        when "immediate"
          idx = get_operand_idx info["value"]
          buf << @operands[idx].value
          if info["size"] == 4
            pattern << "l<"
          else
            raise NotImplementedError
          end
        when "ModRM"
          mode = info["mode"].to_i(2)
          reg = @operands[get_operand_idx(info["reg"])].value
          rm = @operands[get_operand_idx(info["rm"])].value
          buf << ((mode << 6) | (reg << 3) | rm)
          pattern << "C"
        when "REX"
          rex = 0b0100
          rex = (rex << 1) | check_rex(info["W"], @operands)
          rex = (rex << 1) | check_rex(info["R"], @operands)
          rex = (rex << 1) | check_rex(info["X"], @operands)
          rex = (rex << 1) | check_rex(info["B"], @operands)
          buf << rex
          pattern << "C"
        else
          raise NotImplementedError, "unknown type #{type}"
        end
      end
      buf.pack pattern
    end

    def get_operand_idx v
      if v =~ /^#(\d+)/
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
        warn "not implemented"
        0
      else
        raise NotImplementedError, v
      end
    end
  end

  def add *params
    possibles = X86_64["instructions"]["ADD"]["forms"].find_all do |insn|
      if insn["operands"].length == params.length
        params.zip(insn["operands"]).all? { |want_op, have_op|
          want_op.type == have_op["type"]
        }
      else
        false
      end
    end

    if possibles.length > 1
      p possibles
      raise NotImplementedError, "too many"
    end
    raise NotImplementedError, "couldn't find instruction" if possibles.length == 0

    insn = possibles.first

    @instructions << Instruction.new(insn, params)
    self
  end

  def imm32 val
    Imm32.new val
  end

  def to_binary
    @instructions.map(&:encode).join.b
  end
end
