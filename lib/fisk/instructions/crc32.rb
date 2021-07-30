# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CRC32
    forms = []
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[3],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0xF2, true) +
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x38, 0) +
          add_opcode(buffer, 0xF0, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # crc32b: r32, r8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[8],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0x66, false) +
          add_prefix(buffer, operands, 0xF2, true) +
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x38, 0) +
          add_opcode(buffer, 0xF1, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # crc32w: r32, r16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[13],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0xF2, true) +
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x38, 0) +
          add_opcode(buffer, 0xF1, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # crc32l: r32, r32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[4],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0xF2, true) +
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x38, 0) +
          add_opcode(buffer, 0xF0, 0) +
          add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # crc32b: r32, m8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[9],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0x66, false) +
          add_prefix(buffer, operands, 0xF2, true) +
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x38, 0) +
          add_opcode(buffer, 0xF1, 0) +
          add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # crc32w: r32, m16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[14],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0xF2, true) +
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x38, 0) +
          add_opcode(buffer, 0xF1, 0) +
          add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # crc32l: r32, m32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
        OPERAND_TYPES[3],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0xF2, true) +
          add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x38, 0) +
          add_opcode(buffer, 0xF0, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # crc32b: r64, r8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
        OPERAND_TYPES[17],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0xF2, true) +
          add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x38, 0) +
          add_opcode(buffer, 0xF1, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # crc32q: r64, r64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
        OPERAND_TYPES[4],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0xF2, true) +
          add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x38, 0) +
          add_opcode(buffer, 0xF0, 0) +
          add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # crc32b: r64, m8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
        OPERAND_TYPES[18],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0xF2, true) +
          add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x38, 0) +
          add_opcode(buffer, 0xF1, 0) +
          add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # crc32q: r64, m64
    forms << Form.new(operands, encodings)
    CRC32 = Instruction.new("CRC32", forms)
  end
end
