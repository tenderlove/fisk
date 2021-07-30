# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPGATHERDQ
    forms = []
    operands = []
    encodings = []
    # vpgatherdq: xmm{k}, vm32x
    operands << OPERAND_TYPES[83]
    operands << OPERAND_TYPES[84]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x90, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpgatherdq: ymm{k}, vm32x
    operands << OPERAND_TYPES[85]
    operands << OPERAND_TYPES[84]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x90, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpgatherdq: zmm{k}, vm32y
    operands << OPERAND_TYPES[86]
    operands << OPERAND_TYPES[87]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x90, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpgatherdq: xmm, vm32x, xmm
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[84]
    operands << OPERAND_TYPES[23]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x90, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpgatherdq: ymm, vm32x, ymm
    operands << OPERAND_TYPES[82]
    operands << OPERAND_TYPES[84]
    operands << OPERAND_TYPES[82]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x90, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VPGATHERDQ = Instruction.new("VPGATHERDQ", forms)
  end
end
