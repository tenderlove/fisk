# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VZEROALL
    forms = []
    operands = []
    encodings = []
    # vzeroall: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x77, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VZEROALL = Fisk::Machine::Instruction.new("VZEROALL", forms)
  end
end
