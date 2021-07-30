# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VFMSUBADD132PD
    forms = []
    operands = [
        OPERAND_TYPES[79],
        OPERAND_TYPES[24],
        OPERAND_TYPES[58],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x97, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubadd132pd: xmm{k}{z}, xmm, m128/m64bcst
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[79],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x97, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubadd132pd: xmm{k}{z}, xmm, xmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[80],
        OPERAND_TYPES[60],
        OPERAND_TYPES[61],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x97, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubadd132pd: ymm{k}{z}, ymm, m256/m64bcst
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[80],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x97, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubadd132pd: ymm{k}{z}, ymm, ymm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[81],
        OPERAND_TYPES[63],
        OPERAND_TYPES[64],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x97, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubadd132pd: zmm{k}{z}, zmm, m512/m64bcst
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[23],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x97, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubadd132pd: xmm, xmm, xmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[23],
        OPERAND_TYPES[24],
        OPERAND_TYPES[25],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x97, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubadd132pd: xmm, xmm, m128
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[82],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x97, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubadd132pd: ymm, ymm, ymm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[82],
        OPERAND_TYPES[60],
        OPERAND_TYPES[66],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x97, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubadd132pd: ymm, ymm, m256
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[81],
        OPERAND_TYPES[63],
        OPERAND_TYPES[63],
        OPERAND_TYPES[67],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x97, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmsubadd132pd: zmm{k}{z}, zmm, zmm, {er}
    forms << Form.new(operands, encodings)
    VFMSUBADD132PD = Instruction.new("VFMSUBADD132PD", forms)
  end
end
