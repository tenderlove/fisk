# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction POP
    POP = Instruction.new("POP", [
    # popw: r16
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
            add_opcode(buffer, 0x58, operands[0].op_value) +
            0
          end
        }.new.freeze,
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, false) +
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x8F, 0) +
            add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # popq: r64
      Form.new([
        OPERAND_TYPES[28],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x58, operands[0].op_value) +
            0
          end
        }.new.freeze,
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x8F, 0) +
            add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # popw: m16
      Form.new([
        OPERAND_TYPES[45],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, false) +
            add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0x8F, 0) +
            add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # popq: m64
      Form.new([
        OPERAND_TYPES[44],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0x8F, 0) +
            add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
