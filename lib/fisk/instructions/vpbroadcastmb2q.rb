# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPBROADCASTMB2Q
    forms = []
    operands = []
    encodings = []
    # vpbroadcastmb2q: xmm, k
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x2A, 0
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
    # vpbroadcastmb2q: ymm, k
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x2A, 0
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
    # vpbroadcastmb2q: zmm, k
    operands << OPERAND_TYPES[97]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x2A, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VPBROADCASTMB2Q = Fisk::Machine::Instruction.new("VPBROADCASTMB2Q", forms)
  end
end
