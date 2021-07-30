# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VCMPPD
    forms = []
    operands = []
    encodings = []
    # vcmppd: k{k}, xmm, m128/m64bcst, imm8
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[58]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0xC2, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcmppd: k{k}, xmm, xmm, imm8
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0xC2, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcmppd: k{k}, ymm, m256/m64bcst, imm8
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[61]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0xC2, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcmppd: k{k}, ymm, ymm, imm8
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0xC2, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcmppd: k{k}, zmm, m512/m64bcst, imm8
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[64]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0xC2, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcmppd: xmm, xmm, xmm, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xC2, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcmppd: xmm, xmm, m128, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xC2, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcmppd: ymm, ymm, ymm, imm8
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xC2, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcmppd: ymm, ymm, m256, imm8
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xC2, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[3].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcmppd: k{k}, zmm, zmm, {sae}, imm8
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[72]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0xC2, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        add_immediate(buffer, operands[4].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    VCMPPD = Instruction.new("VCMPPD", forms)
  end
end
