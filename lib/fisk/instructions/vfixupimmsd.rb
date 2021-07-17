# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VFIXUPIMMSD
    forms = []
    operands = []
    encodings = []
    # vfixupimmsd: xmm{k}{z}, xmm, m64, imm8
    operands << OPERAND_TYPES[79]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[18]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x55, 0
        add_modrm(buffer, operands,
              0,
              operands[0].op_value,
              operands[2].op_value)
        add_immediate buffer, operands[3].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vfixupimmsd: xmm{k}{z}, xmm, xmm, {sae}, imm8
    operands << OPERAND_TYPES[79]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[72]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x55, 0
        add_modrm(buffer, operands,
              3,
              operands[0].op_value,
              operands[2].op_value)
        add_immediate buffer, operands[4].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    VFIXUPIMMSD = Instruction.new("VFIXUPIMMSD", forms)
  end
end
