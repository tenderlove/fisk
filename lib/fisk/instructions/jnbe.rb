# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JNBE
    forms = []
    operands = []
    encodings = []
    # jnbe: rel8
    operands << OPERAND_TYPES[40]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x77, 0) +
        add_code_offset(buffer, operands[0].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # jnbe: rel32
    operands << OPERAND_TYPES[30]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x87, 0) +
        add_code_offset(buffer, operands[0].op_value, 4) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    JNBE = Instruction.new("JNBE", forms)
  end
end
