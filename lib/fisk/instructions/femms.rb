# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction FEMMS
    FEMMS = Instruction.new("FEMMS", [
    # femms: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x0E, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
