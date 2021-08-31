# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERPF1QPS: Sparse Prefetch Packed Single-Precision Floating-Point Data Values with Signed Quadword Indices Using T1 Hint
    VGATHERPF1QPS = Instruction.new("VGATHERPF1QPS", [
    # vgatherpf1qps: vm64z{k}
      Form.new([
        OPERAND_TYPES[91],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0xC7, 0) +
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
