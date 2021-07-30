# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VFMADD132SD
    forms = []
    operands = [
        OPERAND_TYPES[79],
        OPERAND_TYPES[24],
        OPERAND_TYPES[18],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x99, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmadd132sd: xmm{k}{z}, xmm, m64
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
          add_opcode(buffer, 0x99, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmadd132sd: xmm, xmm, xmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[23],
        OPERAND_TYPES[24],
        OPERAND_TYPES[18],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x99, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmadd132sd: xmm, xmm, m64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[79],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[67],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x99, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfmadd132sd: xmm{k}{z}, xmm, xmm, {er}
    forms << Form.new(operands, encodings)
    VFMADD132SD = Instruction.new("VFMADD132SD", forms)
  end
end
