# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPROLD
    forms = []
    operands = []
    encodings = []
    # vprold: xmm{k}{z}, m128/m32bcst, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[68]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x72, 0) +
        add_modrm(buffer,
              0,
              1,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vprold: ymm{k}{z}, m256/m32bcst, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[69]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x72, 0) +
        add_modrm(buffer,
              0,
              1,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vprold: zmm{k}{z}, m512/m32bcst, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[70]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x72, 0) +
        add_modrm(buffer,
              0,
              1,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vprold: xmm{k}{z}, xmm, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x72, 0) +
        add_modrm(buffer,
              3,
              1,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vprold: ymm{k}{z}, ymm, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x72, 0) +
        add_modrm(buffer,
              3,
              1,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vprold: zmm{k}{z}, zmm, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x72, 0) +
        add_modrm(buffer,
              3,
              1,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VPROLD = Instruction.new("VPROLD", forms)
  end
end
