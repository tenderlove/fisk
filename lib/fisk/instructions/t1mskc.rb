# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction T1MSKC
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
              7,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # t1mskc: r32, r32
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
              7,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # t1mskc: r32, m32
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
              7,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # t1mskc: r64, r64
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
              7,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # t1mskc: r64, m64
    forms << Form.new(operands, encodings)
    T1MSKC = Instruction.new("T1MSKC", forms)
  end
end
