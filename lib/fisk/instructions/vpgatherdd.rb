# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPGATHERDD
    forms = []
    operands = []
    encodings = []
    # vpgatherdd: xmm{k}, vm32x
    operands << OPERAND_TYPES[83]
    operands << OPERAND_TYPES[84]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x90, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpgatherdd: ymm{k}, vm32y
    operands << OPERAND_TYPES[85]
    operands << OPERAND_TYPES[87]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x90, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpgatherdd: zmm{k}, vm32z
    operands << OPERAND_TYPES[86]
    operands << OPERAND_TYPES[88]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x90, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpgatherdd: xmm, vm32x, xmm
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[84]
    operands << OPERAND_TYPES[23]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x90, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpgatherdd: ymm, vm32y, ymm
    operands << OPERAND_TYPES[82]
    operands << OPERAND_TYPES[87]
    operands << OPERAND_TYPES[82]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x90, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VPGATHERDD = Fisk::Machine::Instruction.new("VPGATHERDD", forms)
  end
end
