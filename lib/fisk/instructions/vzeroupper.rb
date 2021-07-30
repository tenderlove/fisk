# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VZEROUPPER
    forms = []
    operands = []
    encodings = []
    # vzeroupper: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x77, 0) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VZEROUPPER = Instruction.new("VZEROUPPER", forms)
  end
end
