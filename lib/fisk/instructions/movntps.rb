# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVNTPS
    forms = []
    operands = []
    encodings = []
    # movntps: m128, xmm
    operands << OPERAND_TYPES[53]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[1].value >> 3),
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x2B, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    MOVNTPS = Fisk::Machine::Instruction.new("MOVNTPS", forms)
  end
end
