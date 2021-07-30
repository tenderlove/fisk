# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BLSIC
    forms = []
    operands = [
        OPERAND_TYPES[27],
        OPERAND_TYPES[13],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x01, 0) +
          add_modrm_reg_reg(buffer,
              3,
              6,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # blsic: r32, r32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[27],
        OPERAND_TYPES[14],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x01, 0) +
          add_modrm_reg_mem(buffer,
              0,
              6,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # blsic: r32, m32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[28],
        OPERAND_TYPES[17],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x01, 0) +
          add_modrm_reg_reg(buffer,
              3,
              6,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # blsic: r64, r64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[28],
        OPERAND_TYPES[18],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x01, 0) +
          add_modrm_reg_mem(buffer,
              0,
              6,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # blsic: r64, m64
    forms << Form.new(operands, encodings)
    BLSIC = Instruction.new("BLSIC", forms)
  end
end
