# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CLD
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0xFC, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # cld: 
    forms << Form.new(operands, encodings)
    CLD = Instruction.new("CLD", forms)
  end
end
