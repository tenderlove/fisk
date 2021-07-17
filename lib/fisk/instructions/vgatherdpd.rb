# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERDPD
    forms = []
    operands = []
    encodings = []
    # vgatherdpd: xmm{k}, vm32x
    operands << OPERAND_TYPES[83]
    operands << OPERAND_TYPES[84]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x92, 0
        add_modrm(buffer, operands,
              0,
              operands[0].op_value,
              operands[1].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vgatherdpd: ymm{k}, vm32x
    operands << OPERAND_TYPES[85]
    operands << OPERAND_TYPES[84]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x92, 0
        add_modrm(buffer, operands,
              0,
              operands[0].op_value,
              operands[1].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vgatherdpd: zmm{k}, vm32y
    operands << OPERAND_TYPES[86]
    operands << OPERAND_TYPES[87]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x92, 0
        add_modrm(buffer, operands,
              0,
              operands[0].op_value,
              operands[1].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vgatherdpd: xmm, vm32x, xmm
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[84]
    operands << OPERAND_TYPES[23]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x92, 0
        add_modrm(buffer, operands,
              0,
              operands[0].op_value,
              operands[1].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vgatherdpd: ymm, vm32x, ymm
    operands << OPERAND_TYPES[82]
    operands << OPERAND_TYPES[84]
    operands << OPERAND_TYPES[82]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x92, 0
        add_modrm(buffer, operands,
              0,
              operands[0].op_value,
              operands[1].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VGATHERDPD = Instruction.new("VGATHERDPD", forms)
  end
end
