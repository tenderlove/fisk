# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PINSRQ
    forms = []
    operands = []
    encodings = []
    # pinsrq: xmm, r64, imm8
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, true
        add_rex(buffer, operands,
              true,
              1,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x3A, 0
        add_opcode buffer, 0x22, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 6; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # pinsrq: xmm, m64, imm8
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[18]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, true
        add_rex(buffer, operands,
              true,
              1,
              (operands[0].value >> 3),
              (operands[1].value >> 3),
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x3A, 0
        add_opcode buffer, 0x22, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 6; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    PINSRQ = Fisk::Machine::Instruction.new("PINSRQ", forms)
  end
end
