# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction STD
    forms = []
    operands = []
    encodings = []
    # std: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0xFD, 0) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    STD = Instruction.new("STD", forms)
  end
end
