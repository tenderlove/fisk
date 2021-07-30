# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PAUSE
    PAUSE = Instruction.new("PAUSE", [
    # pause: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0xF3, true) +
            add_opcode(buffer, 0x90, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
