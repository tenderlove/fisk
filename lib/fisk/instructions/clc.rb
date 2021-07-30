# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CLC
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0xF8, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # clc: 
    forms << Form.new(operands, encodings)
    CLC = Instruction.new("CLC", forms)
  end
end
