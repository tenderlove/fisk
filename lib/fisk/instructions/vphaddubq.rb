# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPHADDUBQ
    forms = []
    operands = []
    encodings = []
    # vphaddubq: xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xD3, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vphaddubq: xmm, m128
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xD3, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VPHADDUBQ = Fisk::Machine::Instruction.new("VPHADDUBQ", forms)
  end
end
