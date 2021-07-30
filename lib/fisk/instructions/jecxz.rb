# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JECXZ
    forms = []
    operands = []
    encodings = []
    # jecxz: rel8
    operands << OPERAND_TYPES[40]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0xE3, 0) +
        add_code_offset(buffer, operands[0].op_value, 1) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    JECXZ = Instruction.new("JECXZ", forms)
  end
end
