# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CQO
    CQO = Instruction.new("CQO", [
    # cqto: 
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
            add_opcode(buffer, 0x99, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
