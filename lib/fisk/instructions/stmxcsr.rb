# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction STMXCSR
    forms = []
    operands = [
        OPERAND_TYPES[37],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0xAE, 0) +
          add_modrm(buffer,
              0,
              3,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # stmxcsr: m32
    forms << Form.new(operands, encodings)
    STMXCSR = Instruction.new("STMXCSR", forms)
  end
end
