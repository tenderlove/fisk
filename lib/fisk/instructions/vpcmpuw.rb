# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPCMPUW
    forms = []
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
          add_opcode(buffer, 0x3E, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpcmpuw: k{k}, xmm, xmm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[71],
        OPERAND_TYPES[24],
        OPERAND_TYPES[25],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x3E, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpcmpuw: k{k}, xmm, m128, imm8
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
          add_opcode(buffer, 0x3E, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpcmpuw: k{k}, ymm, ymm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[71],
        OPERAND_TYPES[60],
        OPERAND_TYPES[66],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x3E, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpcmpuw: k{k}, ymm, m256, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[71],
        OPERAND_TYPES[63],
        OPERAND_TYPES[63],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x3E, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpcmpuw: k{k}, zmm, zmm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[71],
        OPERAND_TYPES[63],
        OPERAND_TYPES[78],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x3E, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpcmpuw: k{k}, zmm, m512, imm8
    forms << Form.new(operands, encodings)
    VPCMPUW = Instruction.new("VPCMPUW", forms)
  end
end
