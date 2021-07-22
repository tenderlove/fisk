# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPBROADCASTMW2D
    forms = []
    operands = []
    encodings = []
    # vpbroadcastmw2d: xmm, k
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x3A, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpbroadcastmw2d: ymm, k
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x3A, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpbroadcastmw2d: zmm, k
    operands << OPERAND_TYPES[97]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x3A, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VPBROADCASTMW2D = Instruction.new("VPBROADCASTMW2D", forms)
  end
end
