# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VINSERTF128: Insert Packed Floating-Point Values
    VINSERTF128 = Instruction.new("VINSERTF128", [
    # vinsertf128: ymm, ymm, xmm, imm8
      Form.new([
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x18, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_immediate(buffer, operands[3].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vinsertf128: ymm, ymm, m128, imm8
      Form.new([
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[25],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x18, 0) +
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
