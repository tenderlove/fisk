# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VINSERTI64X4
    VINSERTI64X4 = Instruction.new("VINSERTI64X4", [
    # vinserti64x4: zmm{k}{z}, zmm, ymm, imm8
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[63],
        OPERAND_TYPES[60],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x3A, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
            add_immediate(buffer, operands[3].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vinserti64x4: zmm{k}{z}, zmm, m256, imm8
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[63],
        OPERAND_TYPES[66],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x3A, 0) +
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
