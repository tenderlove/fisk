# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CLC: Clear Carry Flag
    CLC = Instruction.new("CLC", [
    # clc: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xF8, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
