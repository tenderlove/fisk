# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CMPXCHG8B
    forms = []
    operands = []
    encodings = []
    # cmpxchg8b: m64
    operands << OPERAND_TYPES[18]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
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

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    CMPXCHG8B = Fisk::Machine::Instruction.new("CMPXCHG8B", forms)
  end
end
