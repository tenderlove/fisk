# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPMOVDW
    forms = []
    operands = [
        OPERAND_TYPES[57],
        OPERAND_TYPES[24],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x33, 0) +
          add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpmovdw: xmm{k}{z}, xmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[77],
        OPERAND_TYPES[24],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x33, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpmovdw: m64{k}{z}, xmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[57],
        OPERAND_TYPES[60],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x33, 0) +
          add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpmovdw: xmm{k}{z}, ymm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[73],
        OPERAND_TYPES[60],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x33, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpmovdw: m128{k}{z}, ymm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[59],
        OPERAND_TYPES[63],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x33, 0) +
          add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpmovdw: ymm{k}{z}, zmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[74],
        OPERAND_TYPES[63],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x33, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpmovdw: m256{k}{z}, zmm
    forms << Form.new(operands, encodings)
    VPMOVDW = Instruction.new("VPMOVDW", forms)
  end
end
