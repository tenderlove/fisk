# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BLSMSK
    forms = []
    operands = [
        OPERAND_TYPES[27],
        OPERAND_TYPES[13],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xF3, 0) +
          add_modrm_reg_reg(buffer,
              3,
              2,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # blsmsk: r32, r32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[27],
        OPERAND_TYPES[14],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xF3, 0) +
          add_modrm_reg_mem(buffer,
              0,
              2,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # blsmsk: r32, m32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[28],
        OPERAND_TYPES[17],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xF3, 0) +
          add_modrm_reg_reg(buffer,
              3,
              2,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # blsmsk: r64, r64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[28],
        OPERAND_TYPES[18],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xF3, 0) +
          add_modrm_reg_mem(buffer,
              0,
              2,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # blsmsk: r64, m64
    forms << Form.new(operands, encodings)
    BLSMSK = Instruction.new("BLSMSK", forms)
  end
end
