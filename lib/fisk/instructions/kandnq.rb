# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KANDNQ
    forms = []
    operands = []
    encodings = []
    # kandnq: k, k, k
    operands << OPERAND_TYPES[41]
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x42, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    KANDNQ = Fisk::Machine::Instruction.new("KANDNQ", forms)
  end
end
