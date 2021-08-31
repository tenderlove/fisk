# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JPE: Jump if parity even (PF == 1)
    JPE = Instruction.new("JPE", [
    # jpe: rel8
      Form.new([
        OPERAND_TYPES[40],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x7A, 0) +
            add_code_offset(buffer, operands[0].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # jpe: rel32
      Form.new([
        OPERAND_TYPES[30],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x8A, 0) +
            add_code_offset(buffer, operands[0].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
