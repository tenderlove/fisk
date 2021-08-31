# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction STC: Set Carry Flag
    STC = Instruction.new("STC", [
    # stc: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xF9, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
