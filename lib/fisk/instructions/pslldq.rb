# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PSLLDQ
    forms = []
    operands = []
    encodings = []
    # pslldq: xmm, imm8
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, true) +
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x73, 0) +
        add_modrm(buffer,
              3,
              7,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    PSLLDQ = Instruction.new("PSLLDQ", forms)
  end
end
