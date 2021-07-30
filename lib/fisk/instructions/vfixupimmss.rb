# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VFIXUPIMMSS
    forms = []
    operands = [
        OPERAND_TYPES[79],
        OPERAND_TYPES[24],
        OPERAND_TYPES[14],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x55, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[3].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfixupimmss: xmm{k}{z}, xmm, m32, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[79],
        OPERAND_TYPES[24],
        OPERAND_TYPES[24],
        OPERAND_TYPES[72],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0x55, 0) +
          add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands) +
          add_immediate(buffer, operands[4].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # vfixupimmss: xmm{k}{z}, xmm, xmm, {sae}, imm8
    forms << Form.new(operands, encodings)
    VFIXUPIMMSS = Instruction.new("VFIXUPIMMSS", forms)
  end
end
