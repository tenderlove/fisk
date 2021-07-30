# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction INT
    INT = Instruction.new("INT", [
    # int: 3
      Form.new([
        OPERAND_TYPES[39],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xCC, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # int: imm8
      Form.new([
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xCD, 0) +
            add_immediate(buffer, operands[0].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
