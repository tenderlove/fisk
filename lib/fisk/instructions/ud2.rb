# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction UD2
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x0B, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # ud2: 
    forms << Form.new(operands, encodings)
    UD2 = Instruction.new("UD2", forms)
  end
end
