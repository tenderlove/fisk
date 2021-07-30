# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTI64X4
    forms = []
    operands = [
        OPERAND_TYPES[62],
        OPERAND_TYPES[66],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x5B, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vbroadcasti64x4: zmm{k}{z}, m256
    forms << Form.new(operands, encodings)
    VBROADCASTI64X4 = Instruction.new("VBROADCASTI64X4", forms)
  end
end
