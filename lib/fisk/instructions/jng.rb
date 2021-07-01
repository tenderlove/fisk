# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JNG
    forms = []
    operands = []
    encodings = []
    # jng: rel8
    operands << OPERAND_TYPES[40]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x7E, 0
        add_code_offset buffer, operands[0].value, 1
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # jng: rel32
    operands << OPERAND_TYPES[30]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x8E, 0
        add_code_offset buffer, operands[0].value, 4
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    JNG = Instruction.new("JNG", forms)
  end
end
