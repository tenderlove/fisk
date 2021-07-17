# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSTMXCSR
    forms = []
    operands = []
    encodings = []
    # vstmxcsr: m32
    operands << OPERAND_TYPES[37]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xAE, 0
        add_modrm(buffer, operands,
              0,
              3,
              operands[0].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VSTMXCSR = Instruction.new("VSTMXCSR", forms)
  end
end
