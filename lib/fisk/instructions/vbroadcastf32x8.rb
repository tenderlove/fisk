# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTF32X8
    forms = []
    operands = []
    encodings = []
    # vbroadcastf32x8: zmm{k}{z}, m256
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[66]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x1B, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VBROADCASTF32X8 = Instruction.new("VBROADCASTF32X8", forms)
  end
end
