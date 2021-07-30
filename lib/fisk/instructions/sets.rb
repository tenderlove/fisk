# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SETS
    forms = []
    operands = []
    encodings = []
    # sets: r8
    operands << OPERAND_TYPES[47]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x98, 0) +
        add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # sets: m8
    operands << OPERAND_TYPES[43]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0x98, 0) +
        add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    SETS = Instruction.new("SETS", forms)
  end
end
