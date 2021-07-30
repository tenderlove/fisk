# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction DEC
    forms = []
    operands = [
        OPERAND_TYPES[2],
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
          add_opcode(buffer, 0xFE, 0) +
          add_modrm(buffer,
              3,
              1,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # decb: r8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[7],
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
          add_opcode(buffer, 0xFF, 0) +
          add_modrm(buffer,
              3,
              1,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # decw: r16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
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
          add_opcode(buffer, 0xFF, 0) +
          add_modrm(buffer,
              3,
              1,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # decl: r32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
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
          add_opcode(buffer, 0xFF, 0) +
          add_modrm(buffer,
              3,
              1,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # decq: r64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[19],
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
          add_opcode(buffer, 0xFE, 0) +
          add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # decb: m8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[20],
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
          add_opcode(buffer, 0xFF, 0) +
          add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # decw: m16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[21],
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
          add_opcode(buffer, 0xFF, 0) +
          add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # decl: m32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[22],
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
          add_opcode(buffer, 0xFF, 0) +
          add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # decq: m64
    forms << Form.new(operands, encodings)
    DEC = Instruction.new("DEC", forms)
  end
end
