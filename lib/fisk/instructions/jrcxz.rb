# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JRCXZ
    forms = []
    operands = [
        OPERAND_TYPES[40],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0xE3, 0) +
          add_code_offset(buffer, operands[0].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # jrcxz: rel8
    forms << Form.new(operands, encodings)
    JRCXZ = Instruction.new("JRCXZ", forms)
  end
end
