# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JNG
    forms = []
    operands = [
        OPERAND_TYPES[40],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x7E, 0) +
          add_code_offset(buffer, operands[0].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # jng: rel8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[30],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x8E, 0) +
          add_code_offset(buffer, operands[0].op_value, 4) +
          0
        end
      }.new.freeze,
    ].freeze
    # jng: rel32
    forms << Form.new(operands, encodings)
    JNG = Instruction.new("JNG", forms)
  end
end
