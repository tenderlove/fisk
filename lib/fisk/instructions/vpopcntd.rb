# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPOPCNTD: Packed Population Count for Doubleword Integers
    VPOPCNTD = Instruction.new("VPOPCNTD", [
    # vpopcntd: zmm{k}{z}, m512/m32bcst
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[70],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x55, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpopcntd: zmm{k}{z}, zmm
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[63],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x55, 0) +
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
