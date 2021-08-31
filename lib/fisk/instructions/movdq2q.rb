# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVDQ2Q: Move Quadword from XMM to MMX Technology Register
    MOVDQ2Q = Instruction.new("MOVDQ2Q", [
    # movdq2q: mm, xmm
      Form.new([
        OPERAND_TYPES[35],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0xF2, true) +
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xD6, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
