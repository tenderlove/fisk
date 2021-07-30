# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction NEG
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
          add_opcode(buffer, 0xF6, 0) +
          add_modrm(buffer,
              3,
              3,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # negb: r8
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              3,
              3,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # negw: r16
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              3,
              3,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # negl: r32
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              3,
              3,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # negq: r64
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
          add_opcode(buffer, 0xF6, 0) +
          add_modrm(buffer,
              0,
              3,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # negb: m8
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              0,
              3,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # negw: m16
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              0,
              3,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # negl: m32
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
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              0,
              3,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # negq: m64
    forms << Form.new(operands, encodings)
    NEG = Instruction.new("NEG", forms)
  end
end
