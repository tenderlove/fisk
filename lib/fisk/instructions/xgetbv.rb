# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction XGETBV
    forms = []
    operands = []
    encodings = []
    # xgetbv: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x01, 0
        add_opcode buffer, 0xD0, 0
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    XGETBV = Fisk::Machine::Instruction.new("XGETBV", forms)
  end
end
