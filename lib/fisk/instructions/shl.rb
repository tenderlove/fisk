# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SHL
    SHL = Instruction.new("SHL", [
    # shlb: r8, 1
      Form.new([
        OPERAND_TYPES[2],
        OPERAND_TYPES[55],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD0, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlb: r8, imm8
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
            add_opcode(buffer, 0xC0, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlb: r8, cl
      Form.new([
        OPERAND_TYPES[2],
        OPERAND_TYPES[56],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD2, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlw: r16, 1
      Form.new([
        OPERAND_TYPES[7],
        OPERAND_TYPES[55],
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
            add_opcode(buffer, 0xD1, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlw: r16, imm8
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
            add_opcode(buffer, 0xC1, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlw: r16, cl
      Form.new([
        OPERAND_TYPES[7],
        OPERAND_TYPES[56],
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
            add_opcode(buffer, 0xD3, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shll: r32, 1
      Form.new([
        OPERAND_TYPES[12],
        OPERAND_TYPES[55],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD1, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shll: r32, imm8
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
            add_opcode(buffer, 0xC1, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shll: r32, cl
      Form.new([
        OPERAND_TYPES[12],
        OPERAND_TYPES[56],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD3, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlq: r64, 1
      Form.new([
        OPERAND_TYPES[16],
        OPERAND_TYPES[55],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD1, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlq: r64, imm8
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
            add_opcode(buffer, 0xC1, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlq: r64, cl
      Form.new([
        OPERAND_TYPES[16],
        OPERAND_TYPES[56],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD3, 0) +
            add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlb: m8, 1
      Form.new([
        OPERAND_TYPES[19],
        OPERAND_TYPES[55],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD0, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlb: m8, imm8
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
            add_opcode(buffer, 0xC0, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlb: m8, cl
      Form.new([
        OPERAND_TYPES[19],
        OPERAND_TYPES[56],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD2, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlw: m16, 1
      Form.new([
        OPERAND_TYPES[20],
        OPERAND_TYPES[55],
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
            add_opcode(buffer, 0xD1, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlw: m16, imm8
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
            add_opcode(buffer, 0xC1, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlw: m16, cl
      Form.new([
        OPERAND_TYPES[20],
        OPERAND_TYPES[56],
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
            add_opcode(buffer, 0xD3, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shll: m32, 1
      Form.new([
        OPERAND_TYPES[21],
        OPERAND_TYPES[55],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD1, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shll: m32, imm8
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
            add_opcode(buffer, 0xC1, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shll: m32, cl
      Form.new([
        OPERAND_TYPES[21],
        OPERAND_TYPES[56],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD3, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlq: m64, 1
      Form.new([
        OPERAND_TYPES[22],
        OPERAND_TYPES[55],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD1, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlq: m64, imm8
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
            add_opcode(buffer, 0xC1, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # shlq: m64, cl
      Form.new([
        OPERAND_TYPES[22],
        OPERAND_TYPES[56],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0xD3, 0) +
            add_modrm(buffer,
              0,
              4,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
