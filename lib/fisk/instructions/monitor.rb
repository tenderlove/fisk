# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MONITOR
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x01, 0) +
          add_opcode(buffer, 0xC8, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # monitor: 
    forms << Form.new(operands, encodings)
    MONITOR = Instruction.new("MONITOR", forms)
  end
end
