# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BLSI
    forms = []
    operands = []
    encodings = []
    # blsi: r32, r32
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xF3, 0) +
        add_modrm_reg_reg(buffer,
              3,
              3,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # blsi: r32, m32
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xF3, 0) +
        add_modrm_reg_mem(buffer,
              0,
              3,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # blsi: r64, r64
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xF3, 0) +
        add_modrm_reg_reg(buffer,
              3,
              3,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # blsi: r64, m64
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[18]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xF3, 0) +
        add_modrm_reg_mem(buffer,
              0,
              3,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    BLSI = Instruction.new("BLSI", forms)
  end
end
