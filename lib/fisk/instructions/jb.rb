# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JB
    forms = []
    operands = []
    encodings = []
    # jb: rel8
    operands << OPERAND_TYPES[40]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x72, 0
        add_code_offset buffer, operands[0].op_value, 1
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # jb: rel32
    operands << OPERAND_TYPES[30]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x82, 0
        add_code_offset buffer, operands[0].op_value, 4
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    JB = Instruction.new("JB", forms)
  end
end
