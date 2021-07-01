# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KSHIFTLB
    forms = []
    operands = []
    encodings = []
    # kshiftlb: k, k, imm8
    operands << OPERAND_TYPES[41]
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x32, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    KSHIFTLB = Instruction.new("KSHIFTLB", forms)
  end
end
