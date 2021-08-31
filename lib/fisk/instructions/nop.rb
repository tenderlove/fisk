# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction NOP: No Operation
    NOP = Instruction.new("NOP", [
    # nop: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x90, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
