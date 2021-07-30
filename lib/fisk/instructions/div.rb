# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction DIV
    forms = []
    operands = [
        OPERAND_TYPES[3],
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
          add_opcode(buffer, 0xF6, 0) +
          add_modrm(buffer,
              3,
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # divb: r8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[8],
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              3,
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # divw: r16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[13],
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              3,
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # divl: r32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[17],
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              3,
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # divq: r64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[4],
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
          add_opcode(buffer, 0xF6, 0) +
          add_modrm(buffer,
              0,
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # divb: m8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[9],
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              0,
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # divw: m16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[14],
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              0,
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # divl: m32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[18],
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              0,
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # divq: m64
    forms << Form.new(operands, encodings)
    DIV = Instruction.new("DIV", forms)
  end
end
