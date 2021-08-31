# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MFENCE: Memory Fence
    MFENCE = Instruction.new("MFENCE", [
    # mfence: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0xAE, 0) +
            add_opcode(buffer, 0xF0, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
