# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VLDMXCSR
    forms = []
    operands = []
    encodings = []
    # vldmxcsr: m32
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xAE, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VLDMXCSR = Instruction.new("VLDMXCSR", forms)
  end
end
