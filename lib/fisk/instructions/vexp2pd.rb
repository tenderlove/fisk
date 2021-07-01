# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VEXP2PD
    forms = []
    operands = []
    encodings = []
    # vexp2pd: zmm{k}{z}, m512/m64bcst
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[64]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xC8, 0
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
    # vexp2pd: zmm{k}{z}, zmm, {sae}
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[72]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xC8, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VEXP2PD = Fisk::Machine::Instruction.new("VEXP2PD", forms)
  end
end
