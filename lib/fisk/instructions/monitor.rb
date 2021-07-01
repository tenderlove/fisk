# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MONITOR
    forms = []
    operands = []
    encodings = []
    # monitor: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x01, 0
        add_opcode buffer, 0xC8, 0
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    MONITOR = Fisk::Machine::Instruction.new("MONITOR", forms)
  end
end
