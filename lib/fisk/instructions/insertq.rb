# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction INSERTQ
    forms = []
    operands = []
    encodings = []
    # insertq: xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0xF2, true
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x79, 0
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
    # insertq: xmm, xmm, imm8, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[1]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0xF2, true
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x78, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 5; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    INSERTQ = Fisk::Machine::Instruction.new("INSERTQ", forms)
  end
end
