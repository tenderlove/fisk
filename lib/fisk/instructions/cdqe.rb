# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CDQE
    forms = []
    operands = []
    encodings = []
    # cltq: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              0)
        add_opcode buffer, 0x98, 0
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    CDQE = Fisk::Machine::Instruction.new("CDQE", forms)
  end
end
