# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTF64X4
    forms = []
    operands = []
    encodings = []
    # vbroadcastf64x4: zmm{k}{z}, m256
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[66]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x1B, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VBROADCASTF64X4 = Fisk::Machine::Instruction.new("VBROADCASTF64X4", forms)
  end
end
