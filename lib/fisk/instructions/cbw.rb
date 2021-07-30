# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CBW
    CBW = Instruction.new("CBW", [
    # cbtw: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_prefix(buffer, operands, 0x66, false) +
            add_opcode(buffer, 0x98, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
