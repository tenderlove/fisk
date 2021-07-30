# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PREFETCHT2
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
          add_opcode(buffer, 0x18, 0) +
          add_modrm(buffer,
              0,
              3,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # prefetcht2: m8
    forms << Form.new(operands, encodings)
    PREFETCHT2 = Instruction.new("PREFETCHT2", forms)
  end
end
