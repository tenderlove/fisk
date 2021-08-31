# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MWAIT: Monitor Wait
    MWAIT = Instruction.new("MWAIT", [
    # mwait: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x01, 0) +
            add_opcode(buffer, 0xC9, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
