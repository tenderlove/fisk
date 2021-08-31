# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VRSQRT28SS: Approximation to the Reciprocal Square Root of a Scalar Single-Precision Floating-Point Value with Less Than 2^-28 Relative Error
    VRSQRT28SS = Instruction.new("VRSQRT28SS", [
    # vrsqrt28ss: xmm{k}{z}, xmm, m32
      Form.new([
        OPERAND_TYPES[57],
        OPERAND_TYPES[24],
        OPERAND_TYPES[14],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0xCD, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vrsqrt28ss: xmm{k}{z}, xmm, xmm, {sae}
      Form.new([
        OPERAND_TYPES[57],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[72],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0xCD, 0) +
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
