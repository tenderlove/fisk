# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPINSRQ
    forms = []
    operands = []
    encodings = []
    # vpinsrq: xmm, xmm, r64, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x22, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpinsrq: xmm, xmm, r64, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x22, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpinsrq: xmm, xmm, m64, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[18]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x22, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpinsrq: xmm, xmm, m64, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[18]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x22, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VPINSRQ = Instruction.new("VPINSRQ", forms)
  end
end
