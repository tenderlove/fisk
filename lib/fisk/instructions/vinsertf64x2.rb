# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VINSERTF64X2
    forms = []
    operands = []
    encodings = []
    # vinsertf64x2: ymm{k}{z}, ymm, xmm, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x18, 0
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
    # vinsertf64x2: ymm{k}{z}, ymm, m128, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x18, 0
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
    # vinsertf64x2: zmm{k}{z}, zmm, xmm, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x18, 0
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
    # vinsertf64x2: zmm{k}{z}, zmm, m128, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x18, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VINSERTF64X2 = Fisk::Machine::Instruction.new("VINSERTF64X2", forms)
  end
end
