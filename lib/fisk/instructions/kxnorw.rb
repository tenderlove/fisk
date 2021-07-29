# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KXNORW
    forms = []
    operands = []
    encodings = []
    # kxnorw: k, k, k
    operands << OPERAND_TYPES[41]
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x46, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    KXNORW = Instruction.new("KXNORW", forms)
  end
end
