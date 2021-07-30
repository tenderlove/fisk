# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction NOP
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x90, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # nop: 
    forms << Form.new(operands, encodings)
    NOP = Instruction.new("NOP", forms)
  end
end
