# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JRCXZ
    JRCXZ = Instruction.new("JRCXZ", [
    # jrcxz: rel8
      Form.new([
        OPERAND_TYPES[40],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xE3, 0) +
            add_code_offset(buffer, operands[0].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
