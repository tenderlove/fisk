# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERPF0DPS
    forms = []
    operands = [
        OPERAND_TYPES[90],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xC6, 0) +
          add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vgatherpf0dps: vm32z{k}
    forms << Form.new(operands, encodings)
    VGATHERPF0DPS = Instruction.new("VGATHERPF0DPS", forms)
  end
end
