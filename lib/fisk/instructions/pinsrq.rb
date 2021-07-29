# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PINSRQ
    forms = []
    operands = []
    encodings = []
    # pinsrq: xmm, r64, imm8
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, true) +
        add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x3A, 0) +
        add_opcode(buffer, 0x22, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # pinsrq: xmm, m64, imm8
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[18]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, true) +
        add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x3A, 0) +
        add_opcode(buffer, 0x22, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    PINSRQ = Instruction.new("PINSRQ", forms)
  end
end
