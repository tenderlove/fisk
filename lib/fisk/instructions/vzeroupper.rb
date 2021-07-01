# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VZEROUPPER
    forms = []
    operands = []
    encodings = []
    # vzeroupper: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x77, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VZEROUPPER = Fisk::Machine::Instruction.new("VZEROUPPER", forms)
  end
end
