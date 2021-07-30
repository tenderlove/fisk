# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CPUID
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0xA2, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # cpuid: 
    forms << Form.new(operands, encodings)
    CPUID = Instruction.new("CPUID", forms)
  end
end
