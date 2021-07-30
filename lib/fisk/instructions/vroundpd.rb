# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VROUNDPD
    VROUNDPD = Instruction.new("VROUNDPD", [
    # vroundpd: xmm, xmm, imm8
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x09, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vroundpd: xmm, m128, imm8
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[25],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x09, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vroundpd: ymm, ymm, imm8
      Form.new([
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x09, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vroundpd: ymm, m256, imm8
      Form.new([
        OPERAND_TYPES[65],
        OPERAND_TYPES[66],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x09, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
