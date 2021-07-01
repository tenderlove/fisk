# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVD
    forms = []
    operands = []
    encodings = []
    # movd: r32, mm
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[36]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[1].value >> 3),
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x7E, 0
        add_modrm(buffer, operands,
              3,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # movd: r32, xmm
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, true
        add_rex(buffer, operands,
              false,
              0,
              (operands[1].value >> 3),
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x7E, 0
        add_modrm(buffer, operands,
              3,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # movd: mm, r32
    operands << OPERAND_TYPES[35]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x6E, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # movd: mm, m32
    operands << OPERAND_TYPES[35]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              (operands[1].value >> 3),
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x6E, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # movd: xmm, r32
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, true
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x6E, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # movd: xmm, m32
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, true
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              (operands[1].value >> 3),
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x6E, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # movd: m32, mm
    operands << OPERAND_TYPES[37]
    operands << OPERAND_TYPES[36]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[1].value >> 3),
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x7E, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # movd: m32, xmm
    operands << OPERAND_TYPES[37]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, true
        add_rex(buffer, operands,
              false,
              0,
              (operands[1].value >> 3),
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x7E, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    MOVD = Fisk::Machine::Instruction.new("MOVD", forms)
  end
end
