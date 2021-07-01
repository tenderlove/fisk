# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction UD2
    forms = []
    operands = []
    encodings = []
    # ud2: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x0B, 0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    UD2 = Instruction.new("UD2", forms)
  end
end
