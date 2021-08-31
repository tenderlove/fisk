# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction OR: Logical Inclusive OR
    OR = Instruction.new("OR", [
    # orb: al, imm8
      Form.new([
        OPERAND_TYPES[0],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0C, 0) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orb: r8, imm8
      Form.new([
        OPERAND_TYPES[2],
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
            add_opcode(buffer, 0x80, 0) +
            add_modrm(buffer,
              3,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orb: r8, r8
      Form.new([
        OPERAND_TYPES[2],
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
            add_opcode(buffer, 0x08, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0A, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orb: r8, m8
      Form.new([
        OPERAND_TYPES[2],
        OPERAND_TYPES[4],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0A, 0) +
            add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orw: ax, imm16
      Form.new([
        OPERAND_TYPES[5],
        OPERAND_TYPES[6],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, false) +
            add_opcode(buffer, 0x0D, 0) +
            add_immediate(buffer, operands[1].op_value, 2) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orw: r16, imm8
      Form.new([
        OPERAND_TYPES[7],
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
            add_opcode(buffer, 0x83, 0) +
            add_modrm(buffer,
              3,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orw: r16, imm16
      Form.new([
        OPERAND_TYPES[7],
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
            add_opcode(buffer, 0x81, 0) +
            add_modrm(buffer,
              3,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 2) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orw: r16, r16
      Form.new([
        OPERAND_TYPES[7],
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
            add_opcode(buffer, 0x09, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, false) +
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0B, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orw: r16, m16
      Form.new([
        OPERAND_TYPES[7],
        OPERAND_TYPES[9],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, false) +
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0B, 0) +
            add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orl: eax, imm32
      Form.new([
        OPERAND_TYPES[10],
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0D, 0) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orl: r32, imm8
      Form.new([
        OPERAND_TYPES[12],
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
            add_opcode(buffer, 0x83, 0) +
            add_modrm(buffer,
              3,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orl: r32, imm32
      Form.new([
        OPERAND_TYPES[12],
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
            add_opcode(buffer, 0x81, 0) +
            add_modrm(buffer,
              3,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orl: r32, r32
      Form.new([
        OPERAND_TYPES[12],
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
            add_opcode(buffer, 0x09, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0B, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orl: r32, m32
      Form.new([
        OPERAND_TYPES[12],
        OPERAND_TYPES[14],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0B, 0) +
            add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orq: rax, imm32
      Form.new([
        OPERAND_TYPES[15],
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
            add_opcode(buffer, 0x0D, 0) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orq: r64, imm8
      Form.new([
        OPERAND_TYPES[16],
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
            add_opcode(buffer, 0x83, 0) +
            add_modrm(buffer,
              3,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orq: r64, imm32
      Form.new([
        OPERAND_TYPES[16],
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
            add_opcode(buffer, 0x81, 0) +
            add_modrm(buffer,
              3,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orq: r64, r64
      Form.new([
        OPERAND_TYPES[16],
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
            add_opcode(buffer, 0x09, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0B, 0) +
            add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orq: r64, m64
      Form.new([
        OPERAND_TYPES[16],
        OPERAND_TYPES[18],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0B, 0) +
            add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orb: m8, imm8
      Form.new([
        OPERAND_TYPES[19],
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
            add_opcode(buffer, 0x80, 0) +
            add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orb: m8, r8
      Form.new([
        OPERAND_TYPES[19],
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
            add_opcode(buffer, 0x08, 0) +
            add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orw: m16, imm8
      Form.new([
        OPERAND_TYPES[20],
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
            add_opcode(buffer, 0x83, 0) +
            add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orw: m16, imm16
      Form.new([
        OPERAND_TYPES[20],
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
            add_opcode(buffer, 0x81, 0) +
            add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 2) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orw: m16, r16
      Form.new([
        OPERAND_TYPES[20],
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
            add_opcode(buffer, 0x09, 0) +
            add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orl: m32, imm8
      Form.new([
        OPERAND_TYPES[21],
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
            add_opcode(buffer, 0x83, 0) +
            add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orl: m32, imm32
      Form.new([
        OPERAND_TYPES[21],
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
            add_opcode(buffer, 0x81, 0) +
            add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orl: m32, r32
      Form.new([
        OPERAND_TYPES[21],
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
            add_opcode(buffer, 0x09, 0) +
            add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orq: m64, imm8
      Form.new([
        OPERAND_TYPES[22],
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
            add_opcode(buffer, 0x83, 0) +
            add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orq: m64, imm32
      Form.new([
        OPERAND_TYPES[22],
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
            add_opcode(buffer, 0x81, 0) +
            add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # orq: m64, r64
      Form.new([
        OPERAND_TYPES[22],
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
            add_opcode(buffer, 0x09, 0) +
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
