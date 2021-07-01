# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SYSCALL
    forms = []
    operands = []
    encodings = []
    # syscall: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x05, 0
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    SYSCALL = Fisk::Machine::Instruction.new("SYSCALL", forms)
  end
end
