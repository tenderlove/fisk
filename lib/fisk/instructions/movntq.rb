# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVNTQ
    forms = []
    operands = []
    encodings = []
    # movntq: m64, mm
    operands << OPERAND_TYPES[44]
    operands << OPERAND_TYPES[36]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xE7, 0
        add_modrm(buffer, operands,
              0,
              operands[1].op_value,
              operands[0].op_value)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    MOVNTQ = Instruction.new("MOVNTQ", forms)
  end
end
