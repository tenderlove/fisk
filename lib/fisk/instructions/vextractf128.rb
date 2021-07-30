# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VEXTRACTF128
    forms = []
    operands = [
        OPERAND_TYPES[26],
        OPERAND_TYPES[60],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x19, 0) +
          add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[2].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vextractf128: xmm, ymm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[53],
        OPERAND_TYPES[60],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x19, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[2].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vextractf128: m128, ymm, imm8
    forms << Form.new(operands, encodings)
    VEXTRACTF128 = Instruction.new("VEXTRACTF128", forms)
  end
end
