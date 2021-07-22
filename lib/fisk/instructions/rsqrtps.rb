# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RSQRTPS
    forms = []
    operands = []
    encodings = []
    # rsqrtps: xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x52, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rsqrtps: xmm, m128
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x52, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    RSQRTPS = Instruction.new("RSQRTPS", forms)
  end
end
