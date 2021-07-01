# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CVTDQ2PS
    forms = []
    operands = []
    encodings = []
    # cvtdq2ps: xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x5B, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # cvtdq2ps: xmm, m128
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              (operands[1].value >> 3),
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x5B, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    CVTDQ2PS = Fisk::Machine::Instruction.new("CVTDQ2PS", forms)
  end
end
