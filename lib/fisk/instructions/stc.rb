# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction STC
    forms = []
    operands = []
    encodings = []
    # stc: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0xF9, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    STC = Fisk::Machine::Instruction.new("STC", forms)
  end
end
