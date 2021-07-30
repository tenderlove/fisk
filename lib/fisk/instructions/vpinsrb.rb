# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPINSRB
    forms = []
    operands = []
    encodings = []
    # vpinsrb: xmm, xmm, r32, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x20, 0) +
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
    # vpinsrb: xmm, xmm, r32, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x20, 0) +
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
    # vpinsrb: xmm, xmm, m8, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[4]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x20, 0) +
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
    # vpinsrb: xmm, xmm, m8, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[4]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x20, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VPINSRB = Instruction.new("VPINSRB", forms)
  end
end
