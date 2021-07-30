# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KSHIFTLD
    forms = []
    operands = []
    encodings = []
    # kshiftld: k, k, imm8
    operands << OPERAND_TYPES[41]
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x33, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    KSHIFTLD = Instruction.new("KSHIFTLD", forms)
  end
end
