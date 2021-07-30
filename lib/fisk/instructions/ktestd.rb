# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KTESTD
    forms = []
    operands = []
    encodings = []
    # ktestd: k, k
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x99, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    KTESTD = Instruction.new("KTESTD", forms)
  end
end
