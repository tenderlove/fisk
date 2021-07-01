# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VRNDSCALESS
    forms = []
    operands = []
    encodings = []
    # vrndscaless: xmm{k}{z}, xmm, m32, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[14]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x0A, 0
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
    # vrndscaless: xmm{k}{z}, xmm, xmm, {sae}, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[72]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x0A, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
        add_immediate buffer, operands[4].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VRNDSCALESS = Fisk::Machine::Instruction.new("VRNDSCALESS", forms)
  end
end
