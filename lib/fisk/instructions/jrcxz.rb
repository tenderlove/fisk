# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JRCXZ
    forms = []
    operands = []
    encodings = []
    # jrcxz: rel8
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
    JRCXZ = Instruction.new("JRCXZ", forms)
  end
end
