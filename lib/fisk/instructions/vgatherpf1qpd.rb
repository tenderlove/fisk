# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERPF1QPD
    forms = []
    operands = [
        OPERAND_TYPES[91],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xC7, 0) +
          add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vgatherpf1qpd: vm64z{k}
    forms << Form.new(operands, encodings)
    VGATHERPF1QPD = Instruction.new("VGATHERPF1QPD", forms)
  end
end
