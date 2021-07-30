# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PUSH
    forms = []
    operands = [
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x6A, 0) +
          add_immediate(buffer, operands[0].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # pushq: imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[11],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x68, 0) +
          add_immediate(buffer, operands[0].op_value, 4) +
          0
        end
      }.new.freeze,
    ].freeze
    # pushq: imm32
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
          add_opcode(buffer, 0x50, operands[0].op_value) +
          0
        end
      }.new.freeze,
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
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # pushw: r16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[17],
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
          add_opcode(buffer, 0x50, operands[0].op_value) +
          0
        end
      }.new.freeze,
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
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # pushq: r64
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
          add_opcode(buffer, 0xFF, 0) +
          add_modrm(buffer,
              0,
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # pushw: m16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[18],
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
              6,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # pushq: m64
    forms << Form.new(operands, encodings)
    PUSH = Instruction.new("PUSH", forms)
  end
end
