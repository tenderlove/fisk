# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction STC
    forms = []
    operands = []
    encodings = []
    # stc: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0xF9, 0) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    STC = Instruction.new("STC", forms)
  end
end
