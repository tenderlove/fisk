# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction STD
    STD = Instruction.new("STD", [
    # std: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xFD, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
