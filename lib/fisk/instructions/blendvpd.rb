# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BLENDVPD
    BLENDVPD = Instruction.new("BLENDVPD", [
    # blendvpd: xmm, xmm, xmm0
      Form.new([
        OPERAND_TYPES[23],
        OPERAND_TYPES[24],
        OPERAND_TYPES[29],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, true) +
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x38, 0) +
            add_opcode(buffer, 0x15, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # blendvpd: xmm, m128, xmm0
      Form.new([
        OPERAND_TYPES[23],
        OPERAND_TYPES[25],
        OPERAND_TYPES[29],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, true) +
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x38, 0) +
            add_opcode(buffer, 0x15, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
