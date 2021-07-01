# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VINSERTF128
    forms = []
    operands = []
    encodings = []
    # vinsertf128: ymm, ymm, xmm, imm8
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x18, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vinsertf128: ymm, ymm, m128, imm8
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x18, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VINSERTF128 = Fisk::Machine::Instruction.new("VINSERTF128", forms)
  end
end
