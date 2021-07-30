# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JNLE
    JNLE = Instruction.new("JNLE", [
    # jnle: rel8
      Form.new([
        OPERAND_TYPES[40],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x7F, 0) +
            add_code_offset(buffer, operands[0].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # jnle: rel32
      Form.new([
        OPERAND_TYPES[30],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x8F, 0) +
            add_code_offset(buffer, operands[0].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
