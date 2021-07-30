# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPHADDUBD
    forms = []
    operands = []
    encodings = []
    # vphaddubd: xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xD2, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vphaddubd: xmm, m128
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xD2, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VPHADDUBD = Instruction.new("VPHADDUBD", forms)
  end
end
