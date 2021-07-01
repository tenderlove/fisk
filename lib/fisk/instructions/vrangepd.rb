# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VRANGEPD
    forms = []
    operands = []
    encodings = []
    # vrangepd: xmm{k}{z}, xmm, m128/m64bcst, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[58]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x50, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vrangepd: xmm{k}{z}, xmm, xmm, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x50, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vrangepd: ymm{k}{z}, ymm, m256/m64bcst, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[61]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x50, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vrangepd: ymm{k}{z}, ymm, ymm, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x50, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vrangepd: zmm{k}{z}, zmm, m512/m64bcst, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[64]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x50, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vrangepd: zmm{k}{z}, zmm, zmm, {sae}, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[72]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x50, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[4].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VRANGEPD = Fisk::Machine::Instruction.new("VRANGEPD", forms)
  end
end
