# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPGATHERDD: Gather Packed Doubleword Values Using Signed Doubleword Indices
    VPGATHERDD = Instruction.new("VPGATHERDD", [
    # vpgatherdd: xmm{k}, vm32x
      Form.new([
        OPERAND_TYPES[83],
        OPERAND_TYPES[84],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x90, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpgatherdd: ymm{k}, vm32y
      Form.new([
        OPERAND_TYPES[85],
        OPERAND_TYPES[87],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x90, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpgatherdd: zmm{k}, vm32z
      Form.new([
        OPERAND_TYPES[86],
        OPERAND_TYPES[88],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x90, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpgatherdd: xmm, vm32x, xmm
      Form.new([
        OPERAND_TYPES[23],
        OPERAND_TYPES[84],
        OPERAND_TYPES[23],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x90, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpgatherdd: ymm, vm32y, ymm
      Form.new([
        OPERAND_TYPES[82],
        OPERAND_TYPES[87],
        OPERAND_TYPES[82],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x90, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
