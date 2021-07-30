# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VZEROUPPER
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x77, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # vzeroupper: 
    forms << Form.new(operands, encodings)
    VZEROUPPER = Instruction.new("VZEROUPPER", forms)
  end
end
