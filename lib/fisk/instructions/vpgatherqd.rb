# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPGATHERQD
    VPGATHERQD = Instruction.new("VPGATHERQD", [
    # vpgatherqd: xmm{k}, vm64x
      Form.new([
        OPERAND_TYPES[83],
        OPERAND_TYPES[92],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x91, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpgatherqd: xmm{k}, vm64y
      Form.new([
        OPERAND_TYPES[83],
        OPERAND_TYPES[93],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x91, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpgatherqd: ymm{k}, vm64z
      Form.new([
        OPERAND_TYPES[85],
        OPERAND_TYPES[94],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x91, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpgatherqd: xmm, vm64x, xmm
      Form.new([
        OPERAND_TYPES[23],
        OPERAND_TYPES[92],
        OPERAND_TYPES[23],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x91, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpgatherqd: xmm, vm64y, xmm
      Form.new([
        OPERAND_TYPES[23],
        OPERAND_TYPES[93],
        OPERAND_TYPES[23],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x91, 0) +
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
