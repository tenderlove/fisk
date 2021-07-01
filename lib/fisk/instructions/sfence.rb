# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SFENCE
    forms = []
    operands = []
    encodings = []
    # sfence: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xAE, 0
        add_opcode buffer, 0xF8, 0
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    SFENCE = Fisk::Machine::Instruction.new("SFENCE", forms)
  end
end
