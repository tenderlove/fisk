# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPERM2I128
    forms = []
    operands = []
    encodings = []
    # vperm2i128: ymm, ymm, ymm, imm8
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x46, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vperm2i128: ymm, ymm, m256, imm8
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x46, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VPERM2I128 = Instruction.new("VPERM2I128", forms)
  end
end
