# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PAUSE
    forms = []
    operands = []
    encodings = []
    # pause: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0xF3, true) +
        add_opcode(buffer, 0x90, 0) +
        0
      end

      def bytesize; 1; end
    }.new
    forms << Form.new(operands, encodings)
    PAUSE = Instruction.new("PAUSE", forms)
  end
end
