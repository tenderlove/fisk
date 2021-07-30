# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MONITORX
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x01, 0) +
          add_opcode(buffer, 0xFA, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # monitorx: 
    forms << Form.new(operands, encodings)
    MONITORX = Instruction.new("MONITORX", forms)
  end
end
