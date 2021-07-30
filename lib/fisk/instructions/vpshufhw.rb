# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPSHUFHW
    forms = []
    operands = []
    encodings = []
    # vpshufhw: xmm{k}{z}, xmm, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x70, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpshufhw: ymm{k}{z}, ymm, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x70, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpshufhw: zmm{k}{z}, zmm, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x70, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpshufhw: xmm{k}{z}, m128, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x70, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpshufhw: ymm{k}{z}, m256, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x70, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpshufhw: zmm{k}{z}, m512, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[78]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x70, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpshufhw: xmm, xmm, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x70, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpshufhw: xmm, m128, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x70, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpshufhw: ymm, ymm, imm8
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x70, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpshufhw: ymm, m256, imm8
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x70, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    VPSHUFHW = Instruction.new("VPSHUFHW", forms)
  end
end
