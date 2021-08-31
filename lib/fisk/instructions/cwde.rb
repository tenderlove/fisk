# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CWDE: Convert Word to Doubleword
    CWDE = Instruction.new("CWDE", [
    # cwtl: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x98, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
