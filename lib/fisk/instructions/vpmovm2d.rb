# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPMOVM2D
    VPMOVM2D = Instruction.new("VPMOVM2D", [
    # vpmovm2d: xmm, k
      Form.new([
        OPERAND_TYPES[26],
        OPERAND_TYPES[42],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x38, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpmovm2d: ymm, k
      Form.new([
        OPERAND_TYPES[65],
        OPERAND_TYPES[42],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x38, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    # vpmovm2d: zmm, k
      Form.new([
        OPERAND_TYPES[97],
        OPERAND_TYPES[42],
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_EVEX(buffer, operands)
            add_opcode(buffer, 0x38, 0) +
            add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
