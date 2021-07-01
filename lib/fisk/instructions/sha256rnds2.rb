# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SHA256RNDS2
    forms = []
    operands = []
    encodings = []
    # sha256rnds2: xmm, xmm, xmm0
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[29]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x38, 0
        add_opcode buffer, 0xCB, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # sha256rnds2: xmm, m128, xmm0
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[29]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              (operands[1].value >> 3),
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x38, 0
        add_opcode buffer, 0xCB, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    SHA256RNDS2 = Instruction.new("SHA256RNDS2", forms)
  end
end
