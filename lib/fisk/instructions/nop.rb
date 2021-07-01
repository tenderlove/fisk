# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction NOP
    forms = []
    operands = []
    encodings = []
    # nop: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x90, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    NOP = Fisk::Machine::Instruction.new("NOP", forms)
  end
end
