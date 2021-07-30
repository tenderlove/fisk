# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSTMXCSR
    forms = []
    operands = [
        OPERAND_TYPES[37],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xAE, 0) +
          add_modrm(buffer,
              0,
              3,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vstmxcsr: m32
    forms << Form.new(operands, encodings)
    VSTMXCSR = Instruction.new("VSTMXCSR", forms)
  end
end
