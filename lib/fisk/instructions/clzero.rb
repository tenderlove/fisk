# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CLZERO
    forms = []
    operands = []
    encodings = []
    # clzero: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x01, 0) +
        add_opcode(buffer, 0xFC, 0) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    CLZERO = Instruction.new("CLZERO", forms)
  end
end
