# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PINSRB
    forms = []
    operands = []
    encodings = []
    # pinsrb: xmm, r32, imm8
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[1]
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
        add_opcode(buffer, 0x3A, 0) +
        add_opcode(buffer, 0x20, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # pinsrb: xmm, m8, imm8
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[4]
    operands << OPERAND_TYPES[1]
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
        add_opcode(buffer, 0x3A, 0) +
        add_opcode(buffer, 0x20, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    PINSRB = Instruction.new("PINSRB", forms)
  end
end
