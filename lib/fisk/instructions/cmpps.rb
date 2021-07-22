# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CMPPS
    forms = []
    operands = []
    encodings = []
    # cmpps: xmm, xmm, imm8
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC2, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # cmpps: xmm, m128, imm8
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC2, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    CMPPS = Instruction.new("CMPPS", forms)
  end
end
