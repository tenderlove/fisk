# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVQ2DQ
    forms = []
    operands = []
    encodings = []
    # movq2dq: xmm, mm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[36]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0xF3, true
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xD6, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    MOVQ2DQ = Instruction.new("MOVQ2DQ", forms)
  end
end
