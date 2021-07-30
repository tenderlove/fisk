# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VFMSUBADDPD
    forms = []
    operands = [
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x5F, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[3].op_value, operands) +
          add_RegisterByte(buffer, operands)
          0
        end
      }.new.freeze,
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x5F, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_RegisterByte(buffer, operands)
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubaddpd: xmm, xmm, xmm, xmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[25],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x5F, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[3].op_value, operands) +
          add_RegisterByte(buffer, operands)
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubaddpd: xmm, xmm, xmm, m128
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[25],
        OPERAND_TYPES[24],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x5F, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_RegisterByte(buffer, operands)
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubaddpd: xmm, xmm, m128, xmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x5F, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[3].op_value, operands) +
          add_RegisterByte(buffer, operands)
          0
        end
      }.new.freeze,
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x5F, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_RegisterByte(buffer, operands)
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubaddpd: ymm, ymm, ymm, ymm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
        OPERAND_TYPES[66],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x5F, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[3].op_value, operands) +
          add_RegisterByte(buffer, operands)
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubaddpd: ymm, ymm, ymm, m256
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[66],
        OPERAND_TYPES[60],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x5F, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_RegisterByte(buffer, operands)
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubaddpd: ymm, ymm, m256, ymm
    forms << Form.new(operands, encodings)
    VFMSUBADDPD = Instruction.new("VFMSUBADDPD", forms)
  end
end
