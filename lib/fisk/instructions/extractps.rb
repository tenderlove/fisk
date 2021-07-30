# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction EXTRACTPS
    forms = []
    operands = []
    encodings = []
    # extractps: r32, xmm, imm8
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
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
        add_opcode(buffer, 0x3A, 0) +
        add_opcode(buffer, 0x17, 0) +
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 5; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # extractps: m32, xmm, imm8
    operands << OPERAND_TYPES[37]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
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
        add_opcode(buffer, 0x3A, 0) +
        add_opcode(buffer, 0x17, 0) +
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 5; end
    }.new
    forms << Form.new(operands, encodings)
    EXTRACTPS = Instruction.new("EXTRACTPS", forms)
  end
end
