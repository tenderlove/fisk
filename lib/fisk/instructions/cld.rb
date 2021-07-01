# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CLD
    forms = []
    operands = []
    encodings = []
    # cld: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0xFC, 0
      end

      def bytesize; 1; end
    }.new
    forms << Form.new(operands, encodings)
    CLD = Instruction.new("CLD", forms)
  end
end
