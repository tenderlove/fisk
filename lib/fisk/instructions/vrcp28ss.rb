# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VRCP28SS
    forms = []
    operands = []
    encodings = []
    # vrcp28ss: xmm{k}{z}, xmm, m32
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0xCB, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vrcp28ss: xmm{k}{z}, xmm, xmm, {sae}
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[72]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0xCB, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VRCP28SS = Instruction.new("VRCP28SS", forms)
  end
end
