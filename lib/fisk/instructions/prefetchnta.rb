# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PREFETCHNTA
    forms = []
    operands = []
    encodings = []
    # prefetchnta: m8
    operands << OPERAND_TYPES[4]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x18, 0
        add_modrm(buffer, operands,
              0,
              0,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    PREFETCHNTA = Fisk::Machine::Instruction.new("PREFETCHNTA", forms)
  end
end
