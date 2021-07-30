# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BT
    BT = Instruction.new("BT", [
    # btw: r16, imm8
      Form.new([
        OPERAND_TYPES[8],
        OPERAND_TYPES[1],
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
            add_opcode(buffer, 0xBA, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # btw: r16, r16
      Form.new([
        OPERAND_TYPES[8],
        OPERAND_TYPES[8],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, false) +
            add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xA3, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # btl: r32, imm8
      Form.new([
        OPERAND_TYPES[13],
        OPERAND_TYPES[1],
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
            add_opcode(buffer, 0xBA, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # btl: r32, r32
      Form.new([
        OPERAND_TYPES[13],
        OPERAND_TYPES[13],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xA3, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # btq: r64, imm8
      Form.new([
        OPERAND_TYPES[17],
        OPERAND_TYPES[1],
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
            add_opcode(buffer, 0xBA, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # btq: r64, r64
      Form.new([
        OPERAND_TYPES[17],
        OPERAND_TYPES[17],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xA3, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # btw: m16, imm8
      Form.new([
        OPERAND_TYPES[9],
        OPERAND_TYPES[1],
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
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xBA, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # btw: m16, r16
      Form.new([
        OPERAND_TYPES[9],
        OPERAND_TYPES[8],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, false) +
            add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xA3, 0) +
            add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # btl: m32, imm8
      Form.new([
        OPERAND_TYPES[14],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xBA, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # btl: m32, r32
      Form.new([
        OPERAND_TYPES[14],
        OPERAND_TYPES[13],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xA3, 0) +
            add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # btq: m64, imm8
      Form.new([
        OPERAND_TYPES[18],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xBA, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # btq: m64, r64
      Form.new([
        OPERAND_TYPES[18],
        OPERAND_TYPES[17],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xA3, 0) +
            add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
