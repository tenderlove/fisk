# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTI128: Broadcast 128 Bits of Integer Data
    VBROADCASTI128 = Instruction.new("VBROADCASTI128", [
    # vbroadcasti128: ymm, m128
      Form.new([
        OPERAND_TYPES[65],
        OPERAND_TYPES[25],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
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
