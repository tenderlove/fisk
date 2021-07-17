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
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xF7, 0
        add_modrm(buffer, operands,
              3,
              operands[0].op_value,
              operands[1].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VMASKMOVDQU = Instruction.new("VMASKMOVDQU", forms)
  end
end
