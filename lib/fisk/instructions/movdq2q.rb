# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVDQ2Q
    forms = []
    operands = []
    encodings = []
    # movdq2q: mm, xmm
    operands << OPERAND_TYPES[35]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0xF2, true
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xD6, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    MOVDQ2Q = Instruction.new("MOVDQ2Q", forms)
  end
end
