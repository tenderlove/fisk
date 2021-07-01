# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MULSS
    forms = []
    operands = []
    encodings = []
    # mulss: xmm, xmm
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0xF3, true
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x59, 0
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
    # mulss: xmm, m32
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0xF3, true
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              (operands[1].value >> 3),
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x59, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    MULSS = Fisk::Machine::Instruction.new("MULSS", forms)
  end
end
