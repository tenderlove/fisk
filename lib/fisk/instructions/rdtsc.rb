# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RDTSC: Read Time-Stamp Counter
    RDTSC = Instruction.new("RDTSC", [
    # rdtsc: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x31, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
