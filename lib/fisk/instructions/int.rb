# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction INT
    forms = []
    operands = [
        OPERAND_TYPES[39],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0xCC, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # int: 3
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0xCD, 0) +
          add_immediate(buffer, operands[0].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # int: imm8
    forms << Form.new(operands, encodings)
    INT = Instruction.new("INT", forms)
  end
end
