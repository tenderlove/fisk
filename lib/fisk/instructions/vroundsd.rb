# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VROUNDSD
    forms = []
    operands = [
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x0B, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vroundsd: xmm, xmm, xmm, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[26],
        OPERAND_TYPES[24],
        OPERAND_TYPES[18],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_VEX(buffer, operands)
          add_opcode(buffer, 0x0B, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vroundsd: xmm, xmm, m64, imm8
    forms << Form.new(operands, encodings)
    VROUNDSD = Instruction.new("VROUNDSD", forms)
  end
end
