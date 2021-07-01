# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RDRAND
    forms = []
    operands = []
    encodings = []
    # rdrand: r16
    operands << OPERAND_TYPES[38]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC7, 0
        add_modrm(buffer, operands,
              3,
              6,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rdrand: r32
    operands << OPERAND_TYPES[27]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC7, 0
        add_modrm(buffer, operands,
              3,
              6,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rdrand: r64
    operands << OPERAND_TYPES[28]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC7, 0
        add_modrm(buffer, operands,
              3,
              6,
              operands[0].value)
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    RDRAND = Instruction.new("RDRAND", forms)
  end
end
