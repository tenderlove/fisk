# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SETNLE
    forms = []
    operands = []
    encodings = []
    # setnle: r8
    operands << OPERAND_TYPES[47]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x9F, 0
        add_modrm(buffer, operands,
              3,
              0,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # setnle: m8
    operands << OPERAND_TYPES[43]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x9F, 0
        add_modrm(buffer, operands,
              0,
              0,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    SETNLE = Instruction.new("SETNLE", forms)
  end
end
