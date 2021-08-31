# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VFNMSUBSD: Fused Negative Multiply-Subtract of Scalar Double-Precision Floating-Point Values
    VFNMSUBSD = Instruction.new("VFNMSUBSD", [
    # vfnmsubsd: xmm, xmm, xmm, xmm
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x7F, 0) +
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
            add_opcode(buffer, 0x7F, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vfnmsubsd: xmm, xmm, xmm, m64
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[18],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x7F, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[3].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vfnmsubsd: xmm, xmm, m64, xmm
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[18],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x7F, 0) +
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
