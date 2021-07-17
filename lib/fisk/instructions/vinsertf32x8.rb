# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VINSERTF32X8
    forms = []
    operands = []
    encodings = []
    # vinsertf32x8: zmm{k}{z}, zmm, ymm, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x1A, 0
        add_modrm(buffer, operands,
              3,
              operands[0].op_value,
              operands[2].op_value)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vinsertf32x8: zmm{k}{z}, zmm, m256, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x1A, 0
        add_modrm(buffer, operands,
              0,
              operands[0].op_value,
              operands[2].op_value)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    VINSERTF32X8 = Instruction.new("VINSERTF32X8", forms)
  end
end
