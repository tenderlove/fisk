# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BLSMSK: Mask From Lowest Set Bit
    BLSMSK = Instruction.new("BLSMSK", [
    # blsmsk: r32, r32
      Form.new([
        OPERAND_TYPES[27],
        OPERAND_TYPES[13],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0xF3, 0) +
            add_modrm_reg_reg(buffer,
              3,
              2,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # blsmsk: r32, m32
      Form.new([
        OPERAND_TYPES[27],
        OPERAND_TYPES[14],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0xF3, 0) +
            add_modrm_reg_mem(buffer,
              0,
              2,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # blsmsk: r64, r64
      Form.new([
        OPERAND_TYPES[28],
        OPERAND_TYPES[17],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0xF3, 0) +
            add_modrm_reg_reg(buffer,
              3,
              2,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # blsmsk: r64, m64
      Form.new([
        OPERAND_TYPES[28],
        OPERAND_TYPES[18],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0xF3, 0) +
            add_modrm_reg_mem(buffer,
              0,
              2,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
