# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction FEMMS
    forms = []
    operands = []
    encodings = []
    # femms: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x0E, 0) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    FEMMS = Instruction.new("FEMMS", forms)
  end
end
