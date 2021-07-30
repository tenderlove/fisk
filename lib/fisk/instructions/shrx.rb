# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SHRX
    forms = []
    operands = [
        OPERAND_TYPES[27],
        OPERAND_TYPES[13],
        OPERAND_TYPES[13],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # shrxl: r32, r32, r32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[27],
        OPERAND_TYPES[14],
        OPERAND_TYPES[13],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # shrxl: r32, m32, r32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[28],
        OPERAND_TYPES[17],
        OPERAND_TYPES[17],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # shrxq: r64, r64, r64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[28],
        OPERAND_TYPES[18],
        OPERAND_TYPES[17],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # shrxq: r64, m64, r64
    forms << Form.new(operands, encodings)
    SHRX = Instruction.new("SHRX", forms)
  end
end
