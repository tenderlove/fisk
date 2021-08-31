# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VFNMSUBPD: Fused Negative Multiply-Subtract of Packed Double-Precision Floating-Point Values
    VFNMSUBPD = Instruction.new("VFNMSUBPD", [
    # vfnmsubpd: xmm, xmm, xmm, xmm
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x7D, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[3].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x7D, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vfnmsubpd: xmm, xmm, xmm, m128
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[25],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x7D, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[3].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vfnmsubpd: xmm, xmm, m128, xmm
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[25],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x7D, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vfnmsubpd: ymm, ymm, ymm, ymm
      Form.new([
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x7D, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[3].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x7D, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vfnmsubpd: ymm, ymm, ymm, m256
      Form.new([
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
        OPERAND_TYPES[66],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x7D, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[3].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vfnmsubpd: ymm, ymm, m256, ymm
      Form.new([
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[66],
        OPERAND_TYPES[60],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x7D, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
