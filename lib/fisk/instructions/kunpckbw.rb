# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KUNPCKBW
    forms = []
    operands = []
    encodings = []
    # kunpckbw: k, k, k
    operands << OPERAND_TYPES[41]
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x4B, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    KUNPCKBW = Instruction.new("KUNPCKBW", forms)
  end
end
