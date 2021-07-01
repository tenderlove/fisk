# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JZ
    forms = []
    operands = []
    encodings = []
    # jz: rel8
    operands << OPERAND_TYPES[40]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x74, 0
        add_code_offset buffer, operands[0].value, 1
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # jz: rel32
    operands << OPERAND_TYPES[30]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x84, 0
        add_code_offset buffer, operands[0].value, 4
      end

      def bytesize; 6; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    JZ = Fisk::Machine::Instruction.new("JZ", forms)
  end
end
