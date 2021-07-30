# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPINSRB
    VPINSRB = Instruction.new("VPINSRB", [
    # vpinsrb: xmm, xmm, r32, imm8
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[13],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x20, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_immediate(buffer, operands[3].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpinsrb: xmm, xmm, r32, imm8
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[13],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x20, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_immediate(buffer, operands[3].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpinsrb: xmm, xmm, m8, imm8
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[4],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x20, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_immediate(buffer, operands[3].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpinsrb: xmm, xmm, m8, imm8
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[4],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x20, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_immediate(buffer, operands[3].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
