# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RDRAND
    RDRAND = Instruction.new("RDRAND", [
    # rdrand: r16
      Form.new([
        OPERAND_TYPES[38],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, false) +
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xC7, 0) +
            add_modrm(buffer,
              3,
              6,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # rdrand: r32
      Form.new([
        OPERAND_TYPES[27],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xC7, 0) +
            add_modrm(buffer,
              3,
              6,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # rdrand: r64
      Form.new([
        OPERAND_TYPES[28],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xC7, 0) +
            add_modrm(buffer,
              3,
              6,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
