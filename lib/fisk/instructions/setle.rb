# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SETLE: Set byte if less or equal (ZF == 1 or SF != OF)
    SETLE = Instruction.new("SETLE", [
    # setle: r8
      Form.new([
        OPERAND_TYPES[47],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x9E, 0) +
            add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # setle: m8
      Form.new([
        OPERAND_TYPES[43],
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
            add_opcode(buffer, 0x9E, 0) +
            add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
