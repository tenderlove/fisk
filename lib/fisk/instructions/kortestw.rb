# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KORTESTW
    forms = []
    operands = []
    encodings = []
    # kortestw: k, k
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x98, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    KORTESTW = Instruction.new("KORTESTW", forms)
  end
end
