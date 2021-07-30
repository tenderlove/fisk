# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VCMPPS
    forms = []
    operands = [
        OPERAND_TYPES[71],
        OPERAND_TYPES[24],
        OPERAND_TYPES[68],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xC2, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vcmpps: k{k}, xmm, m128/m32bcst, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[71],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xC2, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vcmpps: k{k}, xmm, xmm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[71],
        OPERAND_TYPES[60],
        OPERAND_TYPES[69],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xC2, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vcmpps: k{k}, ymm, m256/m32bcst, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[71],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xC2, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vcmpps: k{k}, ymm, ymm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[71],
        OPERAND_TYPES[63],
        OPERAND_TYPES[70],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xC2, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vcmpps: k{k}, zmm, m512/m32bcst, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xC2, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vcmpps: xmm, xmm, xmm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[25],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xC2, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vcmpps: xmm, xmm, m128, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[60],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xC2, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vcmpps: ymm, ymm, ymm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[65],
        OPERAND_TYPES[60],
        OPERAND_TYPES[66],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xC2, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vcmpps: ymm, ymm, m256, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[71],
        OPERAND_TYPES[63],
        OPERAND_TYPES[63],
        OPERAND_TYPES[72],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xC2, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[4].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vcmpps: k{k}, zmm, zmm, {sae}, imm8
    forms << Form.new(operands, encodings)
    VCMPPS = Instruction.new("VCMPPS", forms)
  end
end
