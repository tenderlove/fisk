# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BEXTR
    BEXTR = Instruction.new("BEXTR", [
    # bextr: r32, r32, imm32
      Form.new([
        OPERAND_TYPES[27],
        OPERAND_TYPES[13],
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x10, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # bextr: r32, r32, r32
      Form.new([
        OPERAND_TYPES[27],
        OPERAND_TYPES[13],
        OPERAND_TYPES[13],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0xF7, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # bextr: r32, m32, imm32
      Form.new([
        OPERAND_TYPES[27],
        OPERAND_TYPES[14],
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x10, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # bextr: r32, m32, r32
      Form.new([
        OPERAND_TYPES[27],
        OPERAND_TYPES[14],
        OPERAND_TYPES[13],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0xF7, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # bextr: r64, r64, imm32
      Form.new([
        OPERAND_TYPES[28],
        OPERAND_TYPES[17],
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x10, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # bextr: r64, r64, r64
      Form.new([
        OPERAND_TYPES[28],
        OPERAND_TYPES[17],
        OPERAND_TYPES[17],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0xF7, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # bextr: r64, m64, imm32
      Form.new([
        OPERAND_TYPES[28],
        OPERAND_TYPES[18],
        OPERAND_TYPES[11],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x10, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 4) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # bextr: r64, m64, r64
      Form.new([
        OPERAND_TYPES[28],
        OPERAND_TYPES[18],
        OPERAND_TYPES[17],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0xF7, 0) +
            add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
