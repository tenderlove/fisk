# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction ROL
    forms = []
    operands = [
        OPERAND_TYPES[2],
        OPERAND_TYPES[55],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolb: r8, 1
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[2],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolb: r8, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[2],
        OPERAND_TYPES[56],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolb: r8, cl
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[7],
        OPERAND_TYPES[55],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolw: r16, 1
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[7],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolw: r16, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[7],
        OPERAND_TYPES[56],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolw: r16, cl
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[55],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # roll: r32, 1
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # roll: r32, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[56],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # roll: r32, cl
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
        OPERAND_TYPES[55],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolq: r64, 1
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolq: r64, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
        OPERAND_TYPES[56],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolq: r64, cl
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[19],
        OPERAND_TYPES[55],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolb: m8, 1
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[19],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolb: m8, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[19],
        OPERAND_TYPES[56],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolb: m8, cl
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[20],
        OPERAND_TYPES[55],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolw: m16, 1
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[20],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolw: m16, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[20],
        OPERAND_TYPES[56],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolw: m16, cl
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[21],
        OPERAND_TYPES[55],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # roll: m32, 1
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[21],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # roll: m32, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[21],
        OPERAND_TYPES[56],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # roll: m32, cl
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[22],
        OPERAND_TYPES[55],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolq: m64, 1
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[22],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolq: m64, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[22],
        OPERAND_TYPES[56],
    ].freeze
    encodings = [
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
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # rolq: m64, cl
    forms << Form.new(operands, encodings)
    ROL = Instruction.new("ROL", forms)
  end
end
