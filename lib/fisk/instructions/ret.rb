# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RET
    forms = []
    operands = []
    encodings = []
    # ret: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0xC3, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # ret: imm16
    operands << OPERAND_TYPES[6]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0xC2, 0
        add_immediate buffer, operands[0].value, 2
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    RET = Fisk::Machine::Instruction.new("RET", forms)
  end
end
