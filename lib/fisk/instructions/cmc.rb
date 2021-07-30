# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CMC
    CMC = Instruction.new("CMC", [
    # cmc: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xF5, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
