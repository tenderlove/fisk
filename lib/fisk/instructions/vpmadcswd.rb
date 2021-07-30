# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPMADCSWD
    VPMADCSWD = Instruction.new("VPMADCSWD", [
    # vpmadcswd: xmm, xmm, xmm, xmm
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0xB6, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpmadcswd: xmm, xmm, m128, xmm
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[25],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0xB6, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_RegisterByte(buffer, operands)
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
