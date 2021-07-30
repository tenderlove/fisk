# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MFENCE
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0xAE, 0) +
          add_opcode(buffer, 0xF0, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # mfence: 
    forms << Form.new(operands, encodings)
    MFENCE = Instruction.new("MFENCE", forms)
  end
end
