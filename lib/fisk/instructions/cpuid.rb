# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CPUID
    forms = []
    operands = []
    encodings = []
    # cpuid: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA2, 0
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    CPUID = Fisk::Machine::Instruction.new("CPUID", forms)
  end
end
