# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SETNE
    forms = []
    operands = []
    encodings = []
    # setne: r8
    operands << OPERAND_TYPES[47]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x95, 0
        add_modrm(buffer, operands,
              3,
              0,
              operands[0].op_value)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # setne: m8
    operands << OPERAND_TYPES[43]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x95, 0
        add_modrm(buffer, operands,
              0,
              0,
              operands[0].op_value)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    SETNE = Instruction.new("SETNE", forms)
  end
end
