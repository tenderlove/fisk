# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RET
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0xC3, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # ret: 
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[6],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0xC2, 0) +
          add_immediate(buffer, operands[0].op_value, 2) +
          0
        end
      }.new.freeze,
    ].freeze
    # ret: imm16
    forms << Form.new(operands, encodings)
    RET = Instruction.new("RET", forms)
  end
end
