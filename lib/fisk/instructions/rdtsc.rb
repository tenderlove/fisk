# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RDTSC
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x31, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # rdtsc: 
    forms << Form.new(operands, encodings)
    RDTSC = Instruction.new("RDTSC", forms)
  end
end
