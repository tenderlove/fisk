# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSCATTERPF1DPS: Sparse Prefetch Packed Single-Precision Floating-Point Data Values with Signed Doubleword Indices Using T1 Hint with Intent to Write
    VSCATTERPF1DPS = Instruction.new("VSCATTERPF1DPS", [
    # vscatterpf1dps: vm32z{k}
      Form.new([
        OPERAND_TYPES[90],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0xC6, 0) +
            add_modrm(buffer,
              0,
              6,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
