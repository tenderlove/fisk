# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MASKMOVQ
    forms = []
    operands = []
    encodings = []
    # maskmovq: mm, mm
    operands << OPERAND_TYPES[36]
    operands << OPERAND_TYPES[36]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xF7, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    MASKMOVQ = Instruction.new("MASKMOVQ", forms)
  end
end
