# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VLDMXCSR
    VLDMXCSR = Instruction.new("VLDMXCSR", [
    # vldmxcsr: m32
      Form.new([
        OPERAND_TYPES[14],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0xAE, 0) +
            add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
