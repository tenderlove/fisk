# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTF128
    forms = []
    operands = []
    encodings = []
    # vbroadcastf128: ymm, m128
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x1A, 0
        add_modrm(buffer, operands,
              0,
              operands[0].op_value,
              operands[1].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VBROADCASTF128 = Instruction.new("VBROADCASTF128", forms)
  end
end
