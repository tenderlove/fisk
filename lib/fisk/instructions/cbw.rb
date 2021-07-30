# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CBW
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0x66, false) +
          add_opcode(buffer, 0x98, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # cbtw: 
    forms << Form.new(operands, encodings)
    CBW = Instruction.new("CBW", forms)
  end
end
