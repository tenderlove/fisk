# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PUSH
    PUSH = Instruction.new("PUSH", [
    # pushq: imm8
      Form.new([
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x6A, 0) +
            add_immediate(buffer, operands[0].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # pushq: imm32
      Form.new([
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x68, 0) +
            add_immediate(buffer, operands[0].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # pushw: r16
      Form.new([
        OPERAND_TYPES[8],
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
            add_opcode(buffer, 0x50, operands[0].op_value) +
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
            add_opcode(buffer, 0xFF, 0) +
            add_modrm(buffer,
              3,
              6,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # pushq: r64
      Form.new([
        OPERAND_TYPES[17],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x50, operands[0].op_value) +
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
            add_opcode(buffer, 0xFF, 0) +
            add_modrm(buffer,
              3,
              6,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # pushw: m16
      Form.new([
        OPERAND_TYPES[9],
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
            add_opcode(buffer, 0xFF, 0) +
            add_modrm(buffer,
              0,
              6,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # pushq: m64
      Form.new([
        OPERAND_TYPES[18],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0xFF, 0) +
            add_modrm(buffer,
              0,
              6,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
