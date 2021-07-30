# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RET
    RET = Instruction.new("RET", [
    # ret: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xC3, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # ret: imm16
      Form.new([
        OPERAND_TYPES[6],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xC2, 0) +
            add_immediate(buffer, operands[0].op_value, 2) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
