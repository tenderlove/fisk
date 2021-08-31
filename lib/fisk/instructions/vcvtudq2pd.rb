# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VCVTUDQ2PD: Convert Packed Unsigned Doubleword Integers to Packed Double-Precision Floating-Point Values
    VCVTUDQ2PD = Instruction.new("VCVTUDQ2PD", [
    # vcvtudq2pd: xmm{k}{z}, m64/m32bcst
      Form.new([
        OPERAND_TYPES[57],
        OPERAND_TYPES[76],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x7A, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtudq2pd: ymm{k}{z}, m128/m32bcst
      Form.new([
        OPERAND_TYPES[59],
        OPERAND_TYPES[68],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x7A, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtudq2pd: zmm{k}{z}, m256/m32bcst
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[69],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x7A, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtudq2pd: xmm{k}{z}, xmm
      Form.new([
        OPERAND_TYPES[57],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x7A, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtudq2pd: ymm{k}{z}, xmm
      Form.new([
        OPERAND_TYPES[59],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x7A, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vcvtudq2pd: zmm{k}{z}, ymm
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[60],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x7A, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
