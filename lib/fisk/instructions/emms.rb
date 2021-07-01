# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction EMMS
    forms = []
    operands = []
    encodings = []
    # emms: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x77, 0
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    EMMS = Fisk::Machine::Instruction.new("EMMS", forms)
  end
end
