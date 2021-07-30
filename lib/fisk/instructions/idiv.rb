# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction IDIV
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
              7,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # idivb: r8
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
              7,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # idivw: r16
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
              7,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # idivl: r32
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
              7,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # idivq: r64
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
              7,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # idivb: m8
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
              7,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # idivw: m16
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
              7,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # idivl: m32
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
              7,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # idivq: m64
    forms << Form.new(operands, encodings)
    IDIV = Instruction.new("IDIV", forms)
  end
end
