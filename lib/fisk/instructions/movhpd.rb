# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVHPD
    forms = []
    operands = [
        OPERAND_TYPES[23],
        OPERAND_TYPES[18],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0x66, true) +
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x16, 0) +
          add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # movhpd: xmm, m64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[44],
        OPERAND_TYPES[24],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0x66, true) +
          add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
          add_opcode(buffer, 0x0F, 0) +
          add_opcode(buffer, 0x17, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # movhpd: m64, xmm
    forms << Form.new(operands, encodings)
    MOVHPD = Instruction.new("MOVHPD", forms)
  end
end
