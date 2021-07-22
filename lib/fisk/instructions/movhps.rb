# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVHPS
    forms = []
    operands = []
    encodings = []
    # movhps: xmm, m64
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[18]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x16, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # movhps: m64, xmm
    operands << OPERAND_TYPES[44]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x17, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    MOVHPS = Instruction.new("MOVHPS", forms)
  end
end
