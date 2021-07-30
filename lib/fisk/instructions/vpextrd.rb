# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPEXTRD
    forms = []
    operands = [
        OPERAND_TYPES[27],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x16, 0) +
          add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[2].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpextrd: r32, xmm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[27],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x16, 0) +
          add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[2].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpextrd: r32, xmm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[37],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x16, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[2].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpextrd: m32, xmm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[37],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x16, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[2].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpextrd: m32, xmm, imm8
    forms << Form.new(operands, encodings)
    VPEXTRD = Instruction.new("VPEXTRD", forms)
  end
end
