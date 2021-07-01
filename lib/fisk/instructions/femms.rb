# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction FEMMS
    forms = []
    operands = []
    encodings = []
    # femms: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x0E, 0
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    FEMMS = Fisk::Machine::Instruction.new("FEMMS", forms)
  end
end
