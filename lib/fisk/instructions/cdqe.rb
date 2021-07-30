# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CDQE
    CDQE = Instruction.new("CDQE", [
    # cltq: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              0) +
            add_opcode(buffer, 0x98, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
