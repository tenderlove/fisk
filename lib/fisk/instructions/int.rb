# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction INT
    forms = []
    operands = []
    encodings = []
    # int: 3
    operands << OPERAND_TYPES[39]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0xCC, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # int: imm8
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0xCD, 0
        add_immediate buffer, operands[0].value, 1
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    INT = Fisk::Machine::Instruction.new("INT", forms)
  end
end
