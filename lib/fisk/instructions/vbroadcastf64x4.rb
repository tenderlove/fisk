# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTF64X4: Broadcast Four Double-Precision Floating-Point Elements
    VBROADCASTF64X4 = Instruction.new("VBROADCASTF64X4", [
    # vbroadcastf64x4: zmm{k}{z}, m256
      Form.new([
        OPERAND_TYPES[62],
        OPERAND_TYPES[66],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x1B, 0) +
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
