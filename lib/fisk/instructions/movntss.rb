# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVNTSS
    forms = []
    operands = []
    encodings = []
    # movntss: m32, xmm
    operands << OPERAND_TYPES[37]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0xF3, true
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
    forms << Form.new(operands, encodings)
    MOVNTSS = Instruction.new("MOVNTSS", forms)
  end
end
