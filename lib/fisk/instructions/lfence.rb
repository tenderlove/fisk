# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction LFENCE
    forms = []
    operands = []
    encodings = []
    # lfence: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xAE, 0
        add_opcode buffer, 0xE8, 0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    LFENCE = Instruction.new("LFENCE", forms)
  end
end
