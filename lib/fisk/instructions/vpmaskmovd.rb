# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPMASKMOVD
    forms = []
    operands = [
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[25],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x8C, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpmaskmovd: xmm, xmm, m128
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[66],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x8C, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpmaskmovd: ymm, ymm, m256
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[53],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x8E, 0) +
          add_modrm(buffer,
              0,
              operands[2].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpmaskmovd: m128, xmm, xmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[95],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x8E, 0) +
          add_modrm(buffer,
              0,
              operands[2].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpmaskmovd: m256, ymm, ymm
    forms << Form.new(operands, encodings)
    VPMASKMOVD = Instruction.new("VPMASKMOVD", forms)
  end
end
