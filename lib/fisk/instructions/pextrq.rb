# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PEXTRQ: Extract Quadword
    PEXTRQ = Instruction.new("PEXTRQ", [
    # pextrq: r64, xmm, imm8
      Form.new([
        OPERAND_TYPES[28],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, true) +
            add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x3A, 0) +
            add_opcode(buffer, 0x16, 0) +
            add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # pextrq: m64, xmm, imm8
      Form.new([
        OPERAND_TYPES[44],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, true) +
            add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x3A, 0) +
            add_opcode(buffer, 0x16, 0) +
            add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
