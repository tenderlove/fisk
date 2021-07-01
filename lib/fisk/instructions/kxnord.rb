# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KXNORD
    forms = []
    operands = []
    encodings = []
    # kxnord: k, k, k
    operands << OPERAND_TYPES[41]
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x46, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    KXNORD = Fisk::Machine::Instruction.new("KXNORD", forms)
  end
end
