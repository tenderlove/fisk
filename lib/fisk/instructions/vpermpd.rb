# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPERMPD
    VPERMPD = Instruction.new("VPERMPD", [
    # vpermpd: ymm{k}{z}, m256/m64bcst, imm8
      Form.new([
        OPERAND_TYPES[59],
        OPERAND_TYPES[61],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x01, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpermpd: zmm{k}{z}, m512/m64bcst, imm8
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[64],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x01, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpermpd: ymm{k}{z}, ymm, m256/m64bcst
      Form.new([
        OPERAND_TYPES[59],
        OPERAND_TYPES[60],
        OPERAND_TYPES[61],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x16, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpermpd: ymm{k}{z}, ymm, imm8
      Form.new([
        OPERAND_TYPES[59],
        OPERAND_TYPES[60],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x01, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpermpd: ymm{k}{z}, ymm, ymm
      Form.new([
        OPERAND_TYPES[59],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x16, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpermpd: zmm{k}{z}, zmm, m512/m64bcst
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[63],
        OPERAND_TYPES[64],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x16, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpermpd: zmm{k}{z}, zmm, imm8
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[63],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x01, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpermpd: zmm{k}{z}, zmm, zmm
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[63],
        OPERAND_TYPES[63],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x16, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpermpd: ymm, ymm, imm8
      Form.new([
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x01, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpermpd: ymm, m256, imm8
      Form.new([
        OPERAND_TYPES[65],
        OPERAND_TYPES[66],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x01, 0) +
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
