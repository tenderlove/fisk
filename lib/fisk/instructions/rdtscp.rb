# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RDTSCP
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x01, 0) +
          add_opcode(buffer, 0xF9, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # rdtscp: 
    forms << Form.new(operands, encodings)
    RDTSCP = Instruction.new("RDTSCP", forms)
  end
end
