# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CQO
    forms = []
    operands = []
    encodings = []
    # cqto: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              0) +
        add_opcode(buffer, 0x99, 0) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    CQO = Instruction.new("CQO", forms)
  end
end
