# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KXORW
    forms = []
    operands = []
    encodings = []
    # kxorw: k, k, k
    operands << OPERAND_TYPES[41]
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x47, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    KXORW = Fisk::Machine::Instruction.new("KXORW", forms)
  end
end
