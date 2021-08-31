# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MONITORX: Monitor a Linear Address Range with Timeout
    MONITORX = Instruction.new("MONITORX", [
    # monitorx: 
      Form.new([
      ].freeze, [
        Class.new(Fisk::Encoding) {
          def encode buffer, operands
            add_opcode(buffer, 0x0F, 0) +
            add_opcode(buffer, 0x01, 0) +
            add_opcode(buffer, 0xFA, 0) +
            0
          end
        }.new.freeze,
      ].freeze).freeze,
    ].freeze).freeze
  end
end
