# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTI128
    forms = []
    operands = []
    encodings = []
    # vbroadcasti128: ymm, m128
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x5A, 0
        add_modrm(buffer, operands,
              0,
              operands[0].op_value,
              operands[1].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VBROADCASTI128 = Instruction.new("VBROADCASTI128", forms)
  end
end
