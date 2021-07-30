# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CMPXCHG8B
    CMPXCHG8B = Instruction.new("CMPXCHG8B", [
    # cmpxchg8b: m64
      Form.new([
        OPERAND_TYPES[18],
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
            add_opcode(buffer, 0xC7, 0) +
            add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
