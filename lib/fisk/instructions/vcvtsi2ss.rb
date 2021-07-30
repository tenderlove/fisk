# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VCVTSI2SS
    VCVTSI2SS = Instruction.new("VCVTSI2SS", [
    # vcvtsi2ss: xmm, xmm, r32
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[13],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x2A, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtsi2ss: xmm, xmm, r64
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[17],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x2A, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtsi2ss: xmm, xmm, m32
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[14],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x2A, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtsi2ss: xmm, xmm, m32
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[14],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x2A, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtsi2ss: xmm, xmm, m64
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[18],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x2A, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtsi2ss: xmm, xmm, m64
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[18],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x2A, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtsi2ss: xmm, xmm, r32, {er}
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[13],
        OPERAND_TYPES[67],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x2A, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtsi2ss: xmm, xmm, r64, {er}
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[17],
        OPERAND_TYPES[67],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x2A, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
