# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPERMIL2PS
    forms = []
    operands = []
    encodings = []
    # vpermil2ps: xmm, xmm, xmm, xmm, imm4
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x48, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x48, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[3].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpermil2ps: xmm, xmm, xmm, m128, imm4
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x48, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[3].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpermil2ps: xmm, xmm, m128, xmm, imm4
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x48, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpermil2ps: ymm, ymm, ymm, ymm, imm4
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x48, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x48, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[3].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpermil2ps: ymm, ymm, ymm, m256, imm4
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x48, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[3].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpermil2ps: ymm, ymm, m256, ymm, imm4
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[100]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x48, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VPERMIL2PS = Fisk::Machine::Instruction.new("VPERMIL2PS", forms)
  end
end
