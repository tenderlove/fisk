# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KSHIFTRW
    forms = []
    operands = [
        OPERAND_TYPES[41],
        OPERAND_TYPES[42],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x30, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          add_immediate(buffer, operands[2].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # kshiftrw: k, k, imm8
    forms << Form.new(operands, encodings)
    KSHIFTRW = Instruction.new("KSHIFTRW", forms)
  end
end
