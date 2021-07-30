# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CDQE
    forms = []
    operands = []
    encodings = []
    # cltq: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              0) +
        add_opcode(buffer, 0x98, 0) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    CDQE = Instruction.new("CDQE", forms)
  end
end
