# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction POP
    forms = []
    operands = [
        OPERAND_TYPES[38],
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
          add_opcode(buffer, 0x58, operands[0].op_value) +
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
          add_opcode(buffer, 0x8F, 0) +
          add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # popw: r16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[28],
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
          add_opcode(buffer, 0x58, operands[0].op_value) +
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
          add_opcode(buffer, 0x8F, 0) +
          add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # popq: r64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[45],
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
          add_opcode(buffer, 0x8F, 0) +
          add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # popw: m16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[44],
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
          add_opcode(buffer, 0x8F, 0) +
          add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # popq: m64
    forms << Form.new(operands, encodings)
    POP = Instruction.new("POP", forms)
  end
end
