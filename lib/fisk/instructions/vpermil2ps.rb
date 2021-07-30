# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPERMIL2PS
    forms = []
    operands = []
    encodings = []
    # vpermil2ps: xmm, xmm, xmm, xmm, imm4
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x48, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_RegisterByte(buffer, operands)
        0
      end
    }.new
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x48, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[3].op_value, operands) +
        add_RegisterByte(buffer, operands)
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpermil2ps: xmm, xmm, xmm, m128, imm4
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x48, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[3].op_value, operands) +
        add_RegisterByte(buffer, operands)
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpermil2ps: xmm, xmm, m128, xmm, imm4
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x48, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_RegisterByte(buffer, operands)
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpermil2ps: ymm, ymm, ymm, ymm, imm4
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x48, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_RegisterByte(buffer, operands)
        0
      end
    }.new
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x48, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[3].op_value, operands) +
        add_RegisterByte(buffer, operands)
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpermil2ps: ymm, ymm, ymm, m256, imm4
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x48, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[3].op_value, operands) +
        add_RegisterByte(buffer, operands)
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpermil2ps: ymm, ymm, m256, ymm, imm4
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x48, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_RegisterByte(buffer, operands)
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VPERMIL2PS = Instruction.new("VPERMIL2PS", forms)
  end
end
