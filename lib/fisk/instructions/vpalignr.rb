# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPALIGNR
    forms = []
    operands = []
    encodings = []
    # vpalignr: xmm{k}{z}, xmm, xmm, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpalignr: xmm{k}{z}, xmm, m128, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpalignr: ymm{k}{z}, ymm, ymm, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpalignr: ymm{k}{z}, ymm, m256, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpalignr: zmm{k}{z}, zmm, zmm, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpalignr: zmm{k}{z}, zmm, m512, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[78]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpalignr: xmm, xmm, xmm, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpalignr: xmm, xmm, m128, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpalignr: ymm, ymm, ymm, imm8
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpalignr: ymm, ymm, m256, imm8
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    VPALIGNR = Instruction.new("VPALIGNR", forms)
  end
end
