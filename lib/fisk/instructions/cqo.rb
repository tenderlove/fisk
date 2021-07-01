# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CQO
    forms = []
    operands = []
    encodings = []
    # cqto: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              0)
        add_opcode buffer, 0x99, 0
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    CQO = Fisk::Machine::Instruction.new("CQO", forms)
  end
end
