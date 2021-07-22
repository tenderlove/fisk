# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPTESTMQ
    forms = []
    operands = []
    encodings = []
    # vptestmq: k{k}, xmm, m128/m64bcst
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[58]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x27, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vptestmq: k{k}, xmm, xmm
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x27, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vptestmq: k{k}, ymm, m256/m64bcst
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[61]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x27, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vptestmq: k{k}, ymm, ymm
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x27, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vptestmq: k{k}, zmm, m512/m64bcst
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[64]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x27, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vptestmq: k{k}, zmm, zmm
    operands << OPERAND_TYPES[71]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[63]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x27, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VPTESTMQ = Instruction.new("VPTESTMQ", forms)
  end
end
