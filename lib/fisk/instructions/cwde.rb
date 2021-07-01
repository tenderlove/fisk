# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CWDE
    forms = []
    operands = []
    encodings = []
    # cwtl: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x98, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    CWDE = Fisk::Machine::Instruction.new("CWDE", forms)
  end
end
