# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MWAIT
    forms = []
    operands = []
    encodings = []
    # mwait: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x01, 0) +
        add_opcode(buffer, 0xC9, 0) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    MWAIT = Instruction.new("MWAIT", forms)
  end
end
