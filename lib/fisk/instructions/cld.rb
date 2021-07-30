# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CLD
    CLD = Instruction.new("CLD", [
    # cld: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0xFC, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
