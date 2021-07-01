# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CMC
    forms = []
    operands = []
    encodings = []
    # cmc: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0xF5, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    CMC = Fisk::Machine::Instruction.new("CMC", forms)
  end
end
