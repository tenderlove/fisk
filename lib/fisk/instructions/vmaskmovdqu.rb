# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VMASKMOVDQU
    forms = []
    operands = []
    encodings = []
    # vmaskmovdqu: xmm, xmm
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xF7, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VMASKMOVDQU = Fisk::Machine::Instruction.new("VMASKMOVDQU", forms)
  end
end
