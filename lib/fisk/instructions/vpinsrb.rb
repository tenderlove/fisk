# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPINSRB
    forms = []
    operands = []
    encodings = []
    # vpinsrb: xmm, xmm, r32, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x20, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpinsrb: xmm, xmm, r32, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x20, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpinsrb: xmm, xmm, m8, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[4]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x20, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpinsrb: xmm, xmm, m8, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[4]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x20, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[3].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VPINSRB = Fisk::Machine::Instruction.new("VPINSRB", forms)
  end
end
