# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KXNORW
    KXNORW = Instruction.new("KXNORW", [
    # kxnorw: k, k, k
      Form.new([
        OPERAND_TYPES[41],
        OPERAND_TYPES[42],
        OPERAND_TYPES[42],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x46, 0) +
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
