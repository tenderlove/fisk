# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VMASKMOVDQU
    forms = []
    operands = [
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0xF7, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vmaskmovdqu: xmm, xmm
    forms << Form.new(operands, encodings)
    VMASKMOVDQU = Instruction.new("VMASKMOVDQU", forms)
  end
end
