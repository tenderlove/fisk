# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VFNMADD132SS: Fused Negative Multiply-Add of Scalar Single-Precision Floating-Point Values
    VFNMADD132SS = Instruction.new("VFNMADD132SS", [
    # vfnmadd132ss: xmm{k}{z}, xmm, m32
      Form.new([
        OPERAND_TYPES[79],
        OPERAND_TYPES[24],
        OPERAND_TYPES[14],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x9D, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vfnmadd132ss: xmm, xmm, xmm
      Form.new([
        OPERAND_TYPES[23],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x9D, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vfnmadd132ss: xmm, xmm, m32
      Form.new([
        OPERAND_TYPES[23],
        OPERAND_TYPES[24],
        OPERAND_TYPES[14],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x9D, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vfnmadd132ss: xmm{k}{z}, xmm, xmm, {er}
      Form.new([
        OPERAND_TYPES[79],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[67],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x9D, 0) +
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
