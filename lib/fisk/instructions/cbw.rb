# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CBW
    forms = []
    operands = []
    encodings = []
    # cbtw: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_opcode buffer, 0x98, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    CBW = Fisk::Machine::Instruction.new("CBW", forms)
  end
end
