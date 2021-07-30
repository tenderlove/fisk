# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CWDE
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x98, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # cwtl: 
    forms << Form.new(operands, encodings)
    CWDE = Instruction.new("CWDE", forms)
  end
end
