# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction EMMS
    forms = []
    operands = []
    encodings = []
    # emms: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x77, 0) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    EMMS = Instruction.new("EMMS", forms)
  end
end
