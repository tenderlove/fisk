# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KSHIFTLW
    forms = []
    operands = []
    encodings = []
    # kshiftlw: k, k, imm8
    operands << OPERAND_TYPES[41]
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x32, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    KSHIFTLW = Fisk::Machine::Instruction.new("KSHIFTLW", forms)
  end
end
