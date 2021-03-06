# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTF64X2
    forms = []
    operands = []
    encodings = []
    # vbroadcastf64x2: ymm{k}{z}, m128
    operands << OPERAND_TYPES[59]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x1A, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vbroadcastf64x2: zmm{k}{z}, m128
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x1A, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VBROADCASTF64X2 = Instruction.new("VBROADCASTF64X2", forms)
  end
end
