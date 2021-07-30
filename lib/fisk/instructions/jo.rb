# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JO
    forms = []
    operands = [
        OPERAND_TYPES[40],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x70, 0) +
          add_code_offset(buffer, operands[0].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # jo: rel8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[30],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x80, 0) +
          add_code_offset(buffer, operands[0].op_value, 4) +
          0
        end
      }.new.freeze,
    ].freeze
    # jo: rel32
    forms << Form.new(operands, encodings)
    JO = Instruction.new("JO", forms)
  end
end
