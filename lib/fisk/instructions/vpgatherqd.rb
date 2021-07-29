# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPGATHERQD
    forms = []
    operands = []
    encodings = []
    # vpgatherqd: xmm{k}, vm64x
    operands << OPERAND_TYPES[83]
    operands << OPERAND_TYPES[92]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x91, 0) +
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
    # vpgatherqd: xmm{k}, vm64y
    operands << OPERAND_TYPES[83]
    operands << OPERAND_TYPES[93]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x91, 0) +
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
    # vpgatherqd: ymm{k}, vm64z
    operands << OPERAND_TYPES[85]
    operands << OPERAND_TYPES[94]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x91, 0) +
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
    # vpgatherqd: xmm, vm64x, xmm
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[92]
    operands << OPERAND_TYPES[23]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x91, 0) +
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
    # vpgatherqd: xmm, vm64y, xmm
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[93]
    operands << OPERAND_TYPES[23]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x91, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VPGATHERQD = Instruction.new("VPGATHERQD", forms)
  end
end
