# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PSWAPD
    PSWAPD = Instruction.new("PSWAPD", [
    # pswapd: mm, mm
      Form.new([
        OPERAND_TYPES[35],
        OPERAND_TYPES[36],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x0F, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_opcode(buffer, 0xBB, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # pswapd: mm, m64
      Form.new([
        OPERAND_TYPES[35],
        OPERAND_TYPES[18],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x0F, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_opcode(buffer, 0xBB, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
