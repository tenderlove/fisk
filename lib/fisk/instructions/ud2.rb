# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction UD2
    UD2 = Instruction.new("UD2", [
    # ud2: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x0B, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
