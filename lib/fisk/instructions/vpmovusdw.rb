# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPMOVUSDW
    forms = []
    operands = []
    encodings = []
    # vpmovusdw: xmm{k}{z}, xmm
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x13, 0
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovusdw: m64{k}{z}, xmm
    operands << OPERAND_TYPES[77]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x13, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovusdw: xmm{k}{z}, ymm
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x13, 0
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovusdw: m128{k}{z}, ymm
    operands << OPERAND_TYPES[73]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x13, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovusdw: ymm{k}{z}, zmm
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[63]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x13, 0
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovusdw: m256{k}{z}, zmm
    operands << OPERAND_TYPES[74]
    operands << OPERAND_TYPES[63]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x13, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VPMOVUSDW = Instruction.new("VPMOVUSDW", forms)
  end
end
