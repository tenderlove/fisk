# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CLC
    forms = []
    operands = []
    encodings = []
    # clc: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0xF8, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    CLC = Fisk::Machine::Instruction.new("CLC", forms)
  end
end
