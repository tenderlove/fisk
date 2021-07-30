# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CDQ
    CDQ = Instruction.new("CDQ", [
    # cltd: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x99, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
