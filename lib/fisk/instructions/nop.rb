# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction NOP
    forms = []
    operands = []
    encodings = []
    # nop: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x90, 0
      end

      def bytesize; 1; end
    }.new
    forms << Form.new(operands, encodings)
    NOP = Instruction.new("NOP", forms)
  end
end
