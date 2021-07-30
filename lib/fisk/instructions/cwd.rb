# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CWD
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0x66, false) +
          add_opcode(buffer, 0x99, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # cwtd: 
    forms << Form.new(operands, encodings)
    CWD = Instruction.new("CWD", forms)
  end
end
