# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KMOVQ
    forms = []
    operands = [
        OPERAND_TYPES[41],
        OPERAND_TYPES[42],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x90, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # kmovq: k, k
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[41],
        OPERAND_TYPES[17],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x92, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # kmovq: k, r64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[41],
        OPERAND_TYPES[18],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x90, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # kmovq: k, m64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[28],
        OPERAND_TYPES[42],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x93, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # kmovq: r64, k
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[44],
        OPERAND_TYPES[42],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x91, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # kmovq: m64, k
    forms << Form.new(operands, encodings)
    KMOVQ = Instruction.new("KMOVQ", forms)
  end
end
