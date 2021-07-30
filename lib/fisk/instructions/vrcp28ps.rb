# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VRCP28PS
    forms = []
    operands = [
        OPERAND_TYPES[62],
        OPERAND_TYPES[70],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xCA, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vrcp28ps: zmm{k}{z}, m512/m32bcst
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[62],
        OPERAND_TYPES[63],
        OPERAND_TYPES[72],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xCA, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vrcp28ps: zmm{k}{z}, zmm, {sae}
    forms << Form.new(operands, encodings)
    VRCP28PS = Instruction.new("VRCP28PS", forms)
  end
end
