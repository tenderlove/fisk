# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction STD
    forms = []
    operands = []
    encodings = []
    # std: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0xFD, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    STD = Fisk::Machine::Instruction.new("STD", forms)
  end
end
