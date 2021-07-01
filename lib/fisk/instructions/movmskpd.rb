# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVMSKPD
    forms = []
    operands = []
    encodings = []
    # movmskpd: r32, xmm
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, true
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x50, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    MOVMSKPD = Fisk::Machine::Instruction.new("MOVMSKPD", forms)
  end
end
