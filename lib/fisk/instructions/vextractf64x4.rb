# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VEXTRACTF64X4
    forms = []
    operands = [
        OPERAND_TYPES[59],
        OPERAND_TYPES[63],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x1B, 0) +
          add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[2].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vextractf64x4: ymm{k}{z}, zmm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[74],
        OPERAND_TYPES[63],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x1B, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[2].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vextractf64x4: m256{k}{z}, zmm, imm8
    forms << Form.new(operands, encodings)
    VEXTRACTF64X4 = Instruction.new("VEXTRACTF64X4", forms)
  end
end
