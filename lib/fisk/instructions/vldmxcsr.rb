# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VLDMXCSR
    forms = []
    operands = []
    encodings = []
    # vldmxcsr: m32
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xAE, 0
        add_modrm(buffer, operands,
              0,
              2,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VLDMXCSR = Fisk::Machine::Instruction.new("VLDMXCSR", forms)
  end
end
