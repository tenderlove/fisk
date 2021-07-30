# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RDTSCP
    RDTSCP = Instruction.new("RDTSCP", [
    # rdtscp: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x01, 0) +
            add_opcode(buffer, 0xF9, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
