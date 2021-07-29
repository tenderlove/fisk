# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTF32X4
    forms = []
    operands = []
    encodings = []
    # vbroadcastf32x4: ymm{k}{z}, m128
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x1A, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vbroadcastf32x4: zmm{k}{z}, m128
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x1A, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VBROADCASTF32X4 = Instruction.new("VBROADCASTF32X4", forms)
  end
end
