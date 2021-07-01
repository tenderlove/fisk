# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VMOVMSKPS
    forms = []
    operands = []
    encodings = []
    # vmovmskps: r32, xmm
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x50, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vmovmskps: r32, ymm
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x50, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VMOVMSKPS = Fisk::Machine::Instruction.new("VMOVMSKPS", forms)
  end
end
