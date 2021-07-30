# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PI2FW
    forms = []
    operands = [
        OPERAND_TYPES[35],
        OPERAND_TYPES[36],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x0F, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          add_opcode(buffer, 0x0C, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # pi2fw: mm, mm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[35],
        OPERAND_TYPES[18],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x0F, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          add_opcode(buffer, 0x0C, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # pi2fw: mm, m64
    forms << Form.new(operands, encodings)
    PI2FW = Instruction.new("PI2FW", forms)
  end
end
