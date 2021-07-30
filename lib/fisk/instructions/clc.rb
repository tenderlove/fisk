# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CLC
    forms = []
    operands = []
    encodings = []
    # clc: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0xF8, 0) +
        0
      end

      def bytesize; 1; end
    }.new
    forms << Form.new(operands, encodings)
    CLC = Instruction.new("CLC", forms)
  end
end
