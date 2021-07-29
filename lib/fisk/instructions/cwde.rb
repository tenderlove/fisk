# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CWDE
    forms = []
    operands = []
    encodings = []
    # cwtl: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x98, 0) +
        0
      end

      def bytesize; 1; end
    }.new
    forms << Form.new(operands, encodings)
    CWDE = Instruction.new("CWDE", forms)
  end
end
