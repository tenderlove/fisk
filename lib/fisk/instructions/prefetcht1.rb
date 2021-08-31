# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PREFETCHT1: Prefetch Data Into Caches using T1 Hint
    PREFETCHT1 = Instruction.new("PREFETCHT1", [
    # prefetcht1: m8
      Form.new([
        OPERAND_TYPES[4],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x18, 0) +
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
