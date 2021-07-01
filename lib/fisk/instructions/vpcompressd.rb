# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPCOMPRESSD
    forms = []
    operands = []
    encodings = []
    # vpcompressd: xmm{k}{z}, xmm
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x8B, 0
        add_modrm(buffer, operands,
              3,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpcompressd: m128{k}{z}, xmm
    operands << OPERAND_TYPES[73]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x8B, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpcompressd: ymm{k}{z}, ymm
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x8B, 0
        add_modrm(buffer, operands,
              3,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpcompressd: m256{k}{z}, ymm
    operands << OPERAND_TYPES[74]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x8B, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpcompressd: zmm{k}{z}, zmm
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x8B, 0
        add_modrm(buffer, operands,
              3,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpcompressd: m512{k}{z}, zmm
    operands << OPERAND_TYPES[75]
    operands << OPERAND_TYPES[63]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x8B, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VPCOMPRESSD = Fisk::Machine::Instruction.new("VPCOMPRESSD", forms)
  end
end
