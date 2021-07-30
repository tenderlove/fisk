# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CMC
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0xF5, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # cmc: 
    forms << Form.new(operands, encodings)
    CMC = Instruction.new("CMC", forms)
  end
end
