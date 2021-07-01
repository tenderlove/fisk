# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction INC
    forms = []
    operands = []
    encodings = []
    # incb: r8
    operands << OPERAND_TYPES[2]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0xFE, 0
        add_modrm(buffer, operands,
              3,
              0,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # incw: r16
    operands << OPERAND_TYPES[7]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0xFF, 0
        add_modrm(buffer, operands,
              3,
              0,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # incl: r32
    operands << OPERAND_TYPES[12]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0xFF, 0
        add_modrm(buffer, operands,
              3,
              0,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # incq: r64
    operands << OPERAND_TYPES[16]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0xFF, 0
        add_modrm(buffer, operands,
              3,
              0,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # incb: m8
    operands << OPERAND_TYPES[19]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0xFE, 0
        add_modrm(buffer, operands,
              0,
              0,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # incw: m16
    operands << OPERAND_TYPES[20]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_rex(buffer, operands,
              false,
              0,
              0,
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0xFF, 0
        add_modrm(buffer, operands,
              0,
              0,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # incl: m32
    operands << OPERAND_TYPES[21]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0xFF, 0
        add_modrm(buffer, operands,
              0,
              0,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # incq: m64
    operands << OPERAND_TYPES[22]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0xFF, 0
        add_modrm(buffer, operands,
              0,
              0,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    INC = Fisk::Machine::Instruction.new("INC", forms)
  end
end
