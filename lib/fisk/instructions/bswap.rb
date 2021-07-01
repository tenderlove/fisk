# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BSWAP
    forms = []
    operands = []
    encodings = []
    # bswapl: r32
    operands << OPERAND_TYPES[12]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC8, operands[0].value
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # bswapq: r64
    operands << OPERAND_TYPES[16]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC8, operands[0].value
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    BSWAP = Fisk::Machine::Instruction.new("BSWAP", forms)
  end
end
