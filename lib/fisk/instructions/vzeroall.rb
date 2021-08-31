# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VZEROALL: Zero All YMM Registers
    VZEROALL = Instruction.new("VZEROALL", [
    # vzeroall: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_VEX(buffer, operands)
            add_opcode(buffer, 0x77, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
