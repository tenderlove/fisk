# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CLZERO
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x01, 0) +
          add_opcode(buffer, 0xFC, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # clzero: 
    forms << Form.new(operands, encodings)
    CLZERO = Instruction.new("CLZERO", forms)
  end
end
