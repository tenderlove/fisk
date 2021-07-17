# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JAE
    forms = []
    operands = []
    encodings = []
    # jae: rel8
    operands << OPERAND_TYPES[40]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x73, 0
        add_code_offset buffer, operands[0].op_value, 1
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # jae: rel32
    operands << OPERAND_TYPES[30]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x83, 0
        add_code_offset buffer, operands[0].op_value, 4
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    JAE = Instruction.new("JAE", forms)
  end
end
