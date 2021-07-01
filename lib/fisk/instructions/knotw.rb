# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KNOTW
    forms = []
    operands = []
    encodings = []
    # knotw: k, k
    operands << OPERAND_TYPES[41]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x44, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    KNOTW = Instruction.new("KNOTW", forms)
  end
end
