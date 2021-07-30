# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CMPXCHG8B
    forms = []
    operands = [
        OPERAND_TYPES[18],
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
          add_opcode(buffer, 0xC7, 0) +
          add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # cmpxchg8b: m64
    forms << Form.new(operands, encodings)
    CMPXCHG8B = Instruction.new("CMPXCHG8B", forms)
  end
end
