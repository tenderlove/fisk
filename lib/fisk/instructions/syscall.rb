# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SYSCALL
    forms = []
    operands = [
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x05, 0) +
          0
        end
      }.new.freeze,
    ].freeze
    # syscall: 
    forms << Form.new(operands, encodings)
    SYSCALL = Instruction.new("SYSCALL", forms)
  end
end
