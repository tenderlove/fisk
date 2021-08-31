# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSCATTERPF1QPD: Sparse Prefetch Packed Double-Precision Floating-Point Data Values with Signed Quadword Indices Using T1 Hint with Intent to Write
    VSCATTERPF1QPD = Instruction.new("VSCATTERPF1QPD", [
    # vscatterpf1qpd: vm64z{k}
      Form.new([
        OPERAND_TYPES[91],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0xC7, 0) +
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
