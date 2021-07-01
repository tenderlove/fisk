# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSTMXCSR
    forms = []
    operands = []
    encodings = []
    # vstmxcsr: m32
    operands << OPERAND_TYPES[37]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xAE, 0
        add_modrm(buffer, operands,
              0,
              3,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VSTMXCSR = Fisk::Machine::Instruction.new("VSTMXCSR", forms)
  end
end
