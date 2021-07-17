# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PCMPEQQ
    forms = []
    operands = []
    encodings = []
    # pcmpeqq: xmm, xmm
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, true
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x38, 0
        add_opcode buffer, 0x29, 0
        add_modrm(buffer, operands,
              3,
              operands[0].op_value,
              operands[1].op_value)
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # pcmpeqq: xmm, m128
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, true
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x38, 0
        add_opcode buffer, 0x29, 0
        add_modrm(buffer, operands,
              0,
              operands[0].op_value,
              operands[1].op_value)
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    PCMPEQQ = Instruction.new("PCMPEQQ", forms)
  end
end
