# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction EMMS
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x77, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # emms: 
    forms << Form.new(operands, encodings)
    EMMS = Instruction.new("EMMS", forms)
  end
end
