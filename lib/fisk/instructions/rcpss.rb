# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RCPSS
    forms = []
    operands = []
    encodings = []
    # rcpss: xmm, xmm
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0xF3, true) +
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x53, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rcpss: xmm, m32
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0xF3, true) +
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x53, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    RCPSS = Instruction.new("RCPSS", forms)
  end
end
