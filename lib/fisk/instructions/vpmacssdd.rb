# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPMACSSDD
    forms = []
    operands = []
    encodings = []
    # vpmacssdd: xmm, xmm, xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x8E, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmacssdd: xmm, xmm, m128, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x8E, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VPMACSSDD = Instruction.new("VPMACSSDD", forms)
  end
end
