# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KXNORB
    forms = []
    operands = []
    encodings = []
    # kxnorb: k, k, k
    operands << OPERAND_TYPES[41]
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x46, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    KXNORB = Instruction.new("KXNORB", forms)
  end
end
