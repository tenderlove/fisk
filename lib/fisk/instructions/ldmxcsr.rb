# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction LDMXCSR
    forms = []
    operands = []
    encodings = []
    # ldmxcsr: m32
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xAE, 0
        add_modrm(buffer, operands,
              0,
              2,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    LDMXCSR = Instruction.new("LDMXCSR", forms)
  end
end
