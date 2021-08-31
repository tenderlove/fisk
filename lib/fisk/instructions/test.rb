# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction TEST: Logical Compare
    TEST = Instruction.new("TEST", [
    # testb: al, imm8
      Form.new([
        OPERAND_TYPES[31],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xA8, 0) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testb: r8, imm8
      Form.new([
        OPERAND_TYPES[3],
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
            add_opcode(buffer, 0xF6, 0) +
            add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testb: r8, r8
      Form.new([
        OPERAND_TYPES[3],
        OPERAND_TYPES[3],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x84, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testw: ax, imm16
      Form.new([
        OPERAND_TYPES[32],
        OPERAND_TYPES[6],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, false) +
            add_opcode(buffer, 0xA9, 0) +
            add_immediate(buffer, operands[1].op_value, 2) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testw: r16, imm16
      Form.new([
        OPERAND_TYPES[8],
        OPERAND_TYPES[6],
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
            add_opcode(buffer, 0xF7, 0) +
            add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 2) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testw: r16, r16
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
            add_opcode(buffer, 0x85, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testl: eax, imm32
      Form.new([
        OPERAND_TYPES[33],
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xA9, 0) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testl: r32, imm32
      Form.new([
        OPERAND_TYPES[13],
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0xF7, 0) +
            add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testl: r32, r32
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
            add_opcode(buffer, 0x85, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testq: rax, imm32
      Form.new([
        OPERAND_TYPES[34],
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              0) +
            add_opcode(buffer, 0xA9, 0) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testq: r64, imm32
      Form.new([
        OPERAND_TYPES[17],
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0xF7, 0) +
            add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testq: r64, r64
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
            add_opcode(buffer, 0x85, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testb: m8, imm8
      Form.new([
        OPERAND_TYPES[4],
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
            add_opcode(buffer, 0xF6, 0) +
            add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testb: m8, r8
      Form.new([
        OPERAND_TYPES[4],
        OPERAND_TYPES[3],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0x84, 0) +
            add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testw: m16, imm16
      Form.new([
        OPERAND_TYPES[9],
        OPERAND_TYPES[6],
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
            add_opcode(buffer, 0xF7, 0) +
            add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 2) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testw: m16, r16
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
            add_opcode(buffer, 0x85, 0) +
            add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testl: m32, imm32
      Form.new([
        OPERAND_TYPES[14],
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0xF7, 0) +
            add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testl: m32, r32
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
            add_opcode(buffer, 0x85, 0) +
            add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testq: m64, imm32
      Form.new([
        OPERAND_TYPES[18],
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0xF7, 0) +
            add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # testq: m64, r64
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
            add_opcode(buffer, 0x85, 0) +
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
