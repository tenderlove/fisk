# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPSRAD
    forms = []
    operands = []
    encodings = []
    # vpsrad: xmm{k}{z}, m128/m32bcst, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[68]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x72, 0
        add_modrm(buffer, operands,
              0,
              4,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: ymm{k}{z}, m256/m32bcst, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[69]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x72, 0
        add_modrm(buffer, operands,
              0,
              4,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: zmm{k}{z}, m512/m32bcst, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[70]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x72, 0
        add_modrm(buffer, operands,
              0,
              4,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: xmm{k}{z}, xmm, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x72, 0
        add_modrm(buffer, operands,
              3,
              4,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: xmm{k}{z}, xmm, xmm
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xE2, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: xmm{k}{z}, xmm, m128
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xE2, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: ymm{k}{z}, ymm, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x72, 0
        add_modrm(buffer, operands,
              3,
              4,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: ymm{k}{z}, ymm, xmm
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xE2, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: ymm{k}{z}, ymm, m128
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xE2, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: zmm{k}{z}, zmm, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x72, 0
        add_modrm(buffer, operands,
              3,
              4,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: zmm{k}{z}, zmm, xmm
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xE2, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: zmm{k}{z}, zmm, m128
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xE2, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: xmm, xmm, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x72, 0
        add_modrm(buffer, operands,
              3,
              4,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: xmm, xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xE2, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: xmm, xmm, m128
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xE2, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: ymm, ymm, imm8
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x72, 0
        add_modrm(buffer, operands,
              3,
              4,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: ymm, ymm, xmm
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xE2, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpsrad: ymm, ymm, m128
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xE2, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VPSRAD = Fisk::Machine::Instruction.new("VPSRAD", forms)
  end
end
