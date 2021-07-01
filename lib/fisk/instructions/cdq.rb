# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CDQ
    forms = []
    operands = []
    encodings = []
    # cltd: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x99, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    CDQ = Fisk::Machine::Instruction.new("CDQ", forms)
  end
end
