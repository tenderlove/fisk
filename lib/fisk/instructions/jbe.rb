# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JBE
    forms = []
    operands = []
    encodings = []
    # jbe: rel8
    operands << OPERAND_TYPES[40]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x76, 0) +
        add_code_offset(buffer, operands[0].op_value, 1) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # jbe: rel32
    operands << OPERAND_TYPES[30]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x86, 0) +
        add_code_offset(buffer, operands[0].op_value, 4) +
        0
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    JBE = Instruction.new("JBE", forms)
  end
end
