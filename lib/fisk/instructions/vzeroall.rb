# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VZEROALL
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
    # vzeroall: 
    forms << Form.new(operands, encodings)
    VZEROALL = Instruction.new("VZEROALL", forms)
  end
end
