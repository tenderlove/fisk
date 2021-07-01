# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction LFENCE
    forms = []
    operands = []
    encodings = []
    # lfence: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xAE, 0
        add_opcode buffer, 0xE8, 0
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    LFENCE = Fisk::Machine::Instruction.new("LFENCE", forms)
  end
end
