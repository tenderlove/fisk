# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CVTTSS2SI
    forms = []
    operands = []
    encodings = []
    # cvttss2si: r32, xmm
    operands << OPERAND_TYPES[27]
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
        add_opcode(buffer, 0x2C, 0) +
        add_modrm(buffer,
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
    # cvttss2si: r32, m32
    operands << OPERAND_TYPES[27]
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
        add_opcode(buffer, 0x2C, 0) +
        add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # cvttss2si: r64, xmm
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0xF3, true) +
        add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x2C, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # cvttss2si: r64, m32
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0xF3, true) +
        add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x2C, 0) +
        add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    CVTTSS2SI = Instruction.new("CVTTSS2SI", forms)
  end
end
