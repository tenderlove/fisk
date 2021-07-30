# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPCMPESTRI
    forms = []
    operands = [
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x61, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          add_immediate(buffer, operands[2].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpcmpestri: xmm, xmm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[24],
        OPERAND_TYPES[25],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x61, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          add_immediate(buffer, operands[2].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpcmpestri: xmm, m128, imm8
    forms << Form.new(operands, encodings)
    VPCMPESTRI = Instruction.new("VPCMPESTRI", forms)
  end
end
