# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MWAITX
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x01, 0) +
          add_opcode(buffer, 0xFB, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # mwaitx: 
    forms << Form.new(operands, encodings)
    MWAITX = Instruction.new("MWAITX", forms)
  end
end
