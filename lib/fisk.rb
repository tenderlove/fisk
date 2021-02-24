require "json"

class Fisk
  X86_64 = JSON.load_file File.join(File.dirname(__FILE__), "x86_64.json")

  module Registers
    class Register < Struct.new(:name, :type, :value, :alias)
      def works? type
        type == self.alias || type == self.type
      end
    end

    EAX = Register.new :eax, "eax", 0
    ECX = Register.new :ecx, "r32", 1
    EDX = Register.new :edx, "r32", 2
    EBX = Register.new :ebx, "r32", 3
    ESP = Register.new :esp, "r32", 4
    EBP = Register.new :ebp, "r32", 5
    ESI = Register.new :esi, "r32", 6
    EDI = Register.new :edi, "r32", 7

    RAX = Register.new :rax, "rax", 0, "r64"
    RCX = Register.new :rcx, "r64", 1
    RDX = Register.new :rdx, "r64", 2
    RBX = Register.new :rbx, "r64", 3
    RSP = Register.new :rsp, "r64", 4
    RBP = Register.new :rbp, "r64", 5
    RSI = Register.new :rsi, "r64", 6
    RDI = Register.new :rdi, "r64", 7
    8.times do |i|
      i += 8
      const_set "R#{i}", Register.new(:"r#{i}", "r64", i)
    end
  end

  class Imm32 < Struct.new(:value)
    def type
      "imm32"
    end

    def works? type; self.type == type; end
  end

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

    def encode
      encoding = @insn["encodings"].first

      buf = []
      pattern = ""
      encoding.each do |type, info|
        case type
        when "opcode" then
          buf << info["byte"].to_i(16)
          pattern << "C"
        when "immediate"
          idx = get_operand_idx info["value"]
          buf << get_operand(idx).value
          if info["size"] == 4
            pattern << "l<"
          else
            raise NotImplementedError
          end
        when "ModRM"
          mode = info["mode"].to_i(2)
          reg = get_operand(get_operand_idx(info["reg"])).value & 0x7
          rm = get_operand(get_operand_idx(info["rm"])).value & 0x7
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

    private

    def get_operand idx
      @operands[idx]
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
        (operands[$1.to_i].value >> 3)
      else
        raise NotImplementedError, v
      end
    end
  end

  def add *params
    possibles = X86_64["instructions"]["ADD"]["forms"].find_all do |insn|
      if insn["operands"].length == params.length
        params.zip(insn["operands"]).all? { |want_op, have_op|
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
      insn = possibles.sort_by { |thing| thing["encodings"].first.size }.first
    else
      insn = possibles.first
    end

    @instructions << Instruction.new(insn, params)
    self
  end

  def imm32 val
    Imm32.new val
  end

  def to_binary
    @instructions.map(&:encode).join
  end
end
