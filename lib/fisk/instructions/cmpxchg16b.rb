# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CMPXCHG16B
    forms = []
    operands = []
    encodings = []
    # cmpxchg16b: m128
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC7, 0
        add_modrm(buffer, operands,
              0,
              1,
              operands[0].value)
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    CMPXCHG16B = Instruction.new("CMPXCHG16B", forms)
  end
end
