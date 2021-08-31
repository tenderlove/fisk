# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction LFENCE: Load Fence
    LFENCE = Instruction.new("LFENCE", [
    # lfence: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xAE, 0) +
            add_opcode(buffer, 0xE8, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
