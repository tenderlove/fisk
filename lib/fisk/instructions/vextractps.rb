# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VEXTRACTPS
    forms = []
    operands = []
    encodings = []
    # vextractps: r32, xmm, imm8
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x17, 0) +
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vextractps: r32, xmm, imm8
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x17, 0) +
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vextractps: m32, xmm, imm8
    operands << OPERAND_TYPES[37]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x17, 0) +
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vextractps: m32, xmm, imm8
    operands << OPERAND_TYPES[37]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x17, 0) +
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VEXTRACTPS = Instruction.new("VEXTRACTPS", forms)
  end
end
