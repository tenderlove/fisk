# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VEXTRACTF32X4
    forms = []
    operands = []
    encodings = []
    # vextractf32x4: xmm{k}{z}, ymm, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x19, 0
        add_modrm(buffer, operands,
              3,
              operands[1].value,
              operands[0].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vextractf32x4: m128{k}{z}, ymm, imm8
    operands << OPERAND_TYPES[73]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x19, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vextractf32x4: xmm{k}{z}, zmm, imm8
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x19, 0
        add_modrm(buffer, operands,
              3,
              operands[1].value,
              operands[0].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # vextractf32x4: m128{k}{z}, zmm, imm8
    operands << OPERAND_TYPES[73]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x19, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
        add_immediate buffer, operands[2].value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VEXTRACTF32X4 = Fisk::Machine::Instruction.new("VEXTRACTF32X4", forms)
  end
end
