# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction JMP
    forms = []
    operands = [
        OPERAND_TYPES[40],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0xEB, 0) +
          add_code_offset(buffer, operands[0].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # jmp: rel8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[30],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0xE9, 0) +
          add_code_offset(buffer, operands[0].op_value, 4) +
          0
        end
      }.new.freeze,
    ].freeze
    # jmp: rel32
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
          add_opcode(buffer, 0xFF, 0) +
          add_modrm(buffer,
              3,
              4,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # jmpq: r64
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
              4,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # jmpq: m64
    forms << Form.new(operands, encodings)
    JMP = Instruction.new("JMP", forms)
  end
end
