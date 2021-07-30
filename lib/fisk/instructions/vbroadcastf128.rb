# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTF128
    forms = []
    operands = [
        OPERAND_TYPES[65],
        OPERAND_TYPES[25],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x1A, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vbroadcastf128: ymm, m128
    forms << Form.new(operands, encodings)
    VBROADCASTF128 = Instruction.new("VBROADCASTF128", forms)
  end
end
