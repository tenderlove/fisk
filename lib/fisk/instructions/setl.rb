# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SETL
    forms = []
    operands = []
    encodings = []
    # setl: r8
    operands << OPERAND_TYPES[47]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x9C, 0) +
        add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # setl: m8
    operands << OPERAND_TYPES[43]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x9C, 0) +
        add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    SETL = Instruction.new("SETL", forms)
  end
end
