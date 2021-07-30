# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVAPD
    forms = []
    operands = []
    encodings = []
    # movapd: xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, true) +
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x28, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, true) +
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x29, 0) +
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # movapd: xmm, m128
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, true) +
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x28, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # movapd: m128, xmm
    operands << OPERAND_TYPES[53]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, true) +
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x29, 0) +
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    MOVAPD = Instruction.new("MOVAPD", forms)
  end
end
