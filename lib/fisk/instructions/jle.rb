# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JLE: Jump if less or equal (ZF == 1 or SF != OF)
    JLE = Instruction.new("JLE", [
    # jle: rel8
      Form.new([
        OPERAND_TYPES[40],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x7E, 0) +
            add_code_offset(buffer, operands[0].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # jle: rel32
      Form.new([
        OPERAND_TYPES[30],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x8E, 0) +
            add_code_offset(buffer, operands[0].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
