# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPMOVSQB
    VPMOVSQB = Instruction.new("VPMOVSQB", [
    # vpmovsqb: xmm{k}{z}, xmm
      Form.new([
        OPERAND_TYPES[57],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x22, 0) +
            add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpmovsqb: m16{k}{z}, xmm
      Form.new([
        OPERAND_TYPES[102],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x22, 0) +
            add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpmovsqb: xmm{k}{z}, ymm
      Form.new([
        OPERAND_TYPES[57],
        OPERAND_TYPES[60],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x22, 0) +
            add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpmovsqb: m32{k}{z}, ymm
      Form.new([
        OPERAND_TYPES[101],
        OPERAND_TYPES[60],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x22, 0) +
            add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpmovsqb: xmm{k}{z}, zmm
      Form.new([
        OPERAND_TYPES[57],
        OPERAND_TYPES[63],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x22, 0) +
            add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpmovsqb: m64{k}{z}, zmm
      Form.new([
        OPERAND_TYPES[77],
        OPERAND_TYPES[63],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x22, 0) +
            add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
