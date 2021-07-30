# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPGATHERDQ
    forms = []
    operands = [
        OPERAND_TYPES[83],
        OPERAND_TYPES[84],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x90, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpgatherdq: xmm{k}, vm32x
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[85],
        OPERAND_TYPES[84],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x90, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpgatherdq: ymm{k}, vm32x
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[86],
        OPERAND_TYPES[87],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x90, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpgatherdq: zmm{k}, vm32y
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[23],
        OPERAND_TYPES[84],
        OPERAND_TYPES[23],
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
    # vpgatherdq: xmm, vm32x, xmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[82],
        OPERAND_TYPES[84],
        OPERAND_TYPES[82],
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
    # vpgatherdq: ymm, vm32x, ymm
    forms << Form.new(operands, encodings)
    VPGATHERDQ = Instruction.new("VPGATHERDQ", forms)
  end
end
