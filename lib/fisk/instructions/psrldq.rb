# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PSRLDQ: Shift Packed Double Quadword Right Logical
    PSRLDQ = Instruction.new("PSRLDQ", [
    # psrldq: xmm, imm8
      Form.new([
        OPERAND_TYPES[23],
        OPERAND_TYPES[1],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, true) +
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x73, 0) +
            add_modrm(buffer,
              3,
              3,
              operands[0].op_value, operands) +
            add_immediate(buffer, operands[1].op_value, 1) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
