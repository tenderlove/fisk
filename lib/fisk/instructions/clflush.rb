# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CLFLUSH
    forms = []
    operands = [
        OPERAND_TYPES[4],
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
              7,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # clflush: m8
    forms << Form.new(operands, encodings)
    CLFLUSH = Instruction.new("CLFLUSH", forms)
  end
end
