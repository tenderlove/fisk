# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVSXD
    forms = []
    operands = []
    encodings = []
    # movslq: r64, r32
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
        add_opcode(buffer, 0x63, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # movslq: r64, m32
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
        add_opcode(buffer, 0x63, 0) +
        add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    MOVSXD = Instruction.new("MOVSXD", forms)
  end
end
