# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PSLLDQ
    forms = []
    operands = []
    encodings = []
    # pslldq: xmm, imm8
    operands << OPERAND_TYPES[23]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, true
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x73, 0
        add_modrm(buffer, operands,
              3,
              7,
              operands[0].value)
        add_immediate buffer, operands[1].value, 1
      end

      def bytesize; 4; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    PSLLDQ = Fisk::Machine::Instruction.new("PSLLDQ", forms)
  end
end
