# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VRCP28PS
    forms = []
    operands = []
    encodings = []
    # vrcp28ps: zmm{k}{z}, m512/m32bcst
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[70]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xCA, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vrcp28ps: zmm{k}{z}, zmm, {sae}
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[72]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xCA, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VRCP28PS = Fisk::Machine::Instruction.new("VRCP28PS", forms)
  end
end
