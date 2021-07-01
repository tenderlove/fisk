# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPSUBUSB
    forms = []
    operands = []
    encodings = []
    # vpsubusb: xmm{k}{z}, xmm, xmm
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xD8, 0
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
    # vpsubusb: xmm{k}{z}, xmm, m128
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xD8, 0
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
    # vpsubusb: ymm{k}{z}, ymm, ymm
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xD8, 0
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
    # vpsubusb: ymm{k}{z}, ymm, m256
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xD8, 0
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
    # vpsubusb: zmm{k}{z}, zmm, zmm
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[63]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xD8, 0
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
    # vpsubusb: zmm{k}{z}, zmm, m512
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[78]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xD8, 0
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
    # vpsubusb: xmm, xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xD8, 0
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
    # vpsubusb: xmm, xmm, m128
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xD8, 0
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
    # vpsubusb: ymm, ymm, ymm
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xD8, 0
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
    # vpsubusb: ymm, ymm, m256
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xD8, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VPSUBUSB = Fisk::Machine::Instruction.new("VPSUBUSB", forms)
  end
end
