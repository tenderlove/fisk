# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction TZMSK
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
              4,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # tzmsk: r32, r32
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
              4,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # tzmsk: r32, m32
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
              4,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # tzmsk: r64, r64
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
              4,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # tzmsk: r64, m64
    forms << Form.new(operands, encodings)
    TZMSK = Instruction.new("TZMSK", forms)
  end
end
