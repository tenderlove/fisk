# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VBROADCASTI32X8
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
    # vbroadcasti32x8: zmm{k}{z}, m256
    forms << Form.new(operands, encodings)
    VBROADCASTI32X8 = Instruction.new("VBROADCASTI32X8", forms)
  end
end
