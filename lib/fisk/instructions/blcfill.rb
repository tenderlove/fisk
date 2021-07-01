# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BLCFILL
    forms = []
    operands = []
    encodings = []
    # blcfill: r32, r32
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x01, 0
        add_modrm(buffer, operands,
              3,
              1,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # blcfill: r32, m32
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x01, 0
        add_modrm(buffer, operands,
              0,
              1,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # blcfill: r64, r64
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x01, 0
        add_modrm(buffer, operands,
              3,
              1,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # blcfill: r64, m64
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[18]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x01, 0
        add_modrm(buffer, operands,
              0,
              1,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    BLCFILL = Fisk::Machine::Instruction.new("BLCFILL", forms)
  end
end
