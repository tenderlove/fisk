# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VEXTRACTF32X8: Extract 256 Bits of Packed Single-Precision Floating-Point Values
    VEXTRACTF32X8 = Instruction.new("VEXTRACTF32X8", [
    # vextractf32x8: ymm{k}{z}, zmm, imm8
      Form.new([
        OPERAND_TYPES[59],
        OPERAND_TYPES[63],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x1B, 0) +
            add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[2].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vextractf32x8: m256{k}{z}, zmm, imm8
      Form.new([
        OPERAND_TYPES[74],
        OPERAND_TYPES[63],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x1B, 0) +
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
