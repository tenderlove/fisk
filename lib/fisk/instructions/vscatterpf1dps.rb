# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSCATTERPF1DPS
    forms = []
    operands = []
    encodings = []
    # vscatterpf1dps: vm32z{k}
    operands << OPERAND_TYPES[90]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0xC6, 0) +
        add_modrm(buffer,
              0,
              6,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VSCATTERPF1DPS = Instruction.new("VSCATTERPF1DPS", forms)
  end
end
