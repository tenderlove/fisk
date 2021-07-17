# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BSWAP
    forms = []
    operands = []
    encodings = []
    # bswapl: r32
    operands << OPERAND_TYPES[12]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC8, operands[0].op_value
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # bswapq: r64
    operands << OPERAND_TYPES[16]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC8, operands[0].op_value
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    BSWAP = Instruction.new("BSWAP", forms)
  end
end
