# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RDTSC
    forms = []
    operands = []
    encodings = []
    # rdtsc: 
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x31, 0) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    RDTSC = Instruction.new("RDTSC", forms)
  end
end
