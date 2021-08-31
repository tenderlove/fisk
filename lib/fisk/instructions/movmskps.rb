# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVMSKPS: Extract Packed Single-Precision Floating-Point Sign Mask
    MOVMSKPS = Instruction.new("MOVMSKPS", [
    # movmskps: r32, xmm
      Form.new([
        OPERAND_TYPES[27],
        OPERAND_TYPES[24],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x50, 0) +
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
