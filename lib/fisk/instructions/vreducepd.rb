# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VREDUCEPD
    forms = []
    operands = []
    encodings = []
    # vreducepd: xmm{k}{z}, m128/m64bcst, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[58]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x56, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vreducepd: ymm{k}{z}, m256/m64bcst, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[61]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x56, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vreducepd: zmm{k}{z}, m512/m64bcst, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[64]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x56, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vreducepd: xmm{k}{z}, xmm, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x56, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vreducepd: ymm{k}{z}, ymm, imm8
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x56, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vreducepd: zmm{k}{z}, zmm, imm8
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x56, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    VREDUCEPD = Instruction.new("VREDUCEPD", forms)
  end
end
