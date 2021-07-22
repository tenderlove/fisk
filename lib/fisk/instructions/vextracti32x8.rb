# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VEXTRACTI32X8
    forms = []
    operands = []
    encodings = []
    # vextracti32x8: ymm{k}{z}, zmm, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x3B, 0
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vextracti32x8: m256{k}{z}, zmm, imm8
    operands << OPERAND_TYPES[74]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x3B, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    VEXTRACTI32X8 = Instruction.new("VEXTRACTI32X8", forms)
  end
end
