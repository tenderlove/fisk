# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSCATTERPF1QPD
    forms = []
    operands = []
    encodings = []
    # vscatterpf1qpd: vm64z{k}
    operands << OPERAND_TYPES[91]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0xC7, 0) +
        add_modrm(buffer,
              0,
              6,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VSCATTERPF1QPD = Instruction.new("VSCATTERPF1QPD", forms)
  end
end
