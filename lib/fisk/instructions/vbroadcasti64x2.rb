# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTI64X2
    VBROADCASTI64X2 = Instruction.new("VBROADCASTI64X2", [
    # vbroadcasti64x2: ymm{k}{z}, m128
      Form.new([
        OPERAND_TYPES[59],
        OPERAND_TYPES[25],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x5A, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vbroadcasti64x2: zmm{k}{z}, m128
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[25],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x5A, 0) +
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
