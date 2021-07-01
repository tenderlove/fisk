# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VEXTRACTI128
    forms = []
    operands = []
    encodings = []
    # vextracti128: xmm, ymm, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x39, 0
        add_modrm(buffer, operands,
              3,
              operands[1].value,
              operands[0].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vextracti128: m128, ymm, imm8
    operands << OPERAND_TYPES[53]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x39, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VEXTRACTI128 = Fisk::Machine::Instruction.new("VEXTRACTI128", forms)
  end
end
