# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERPF1DPD
    forms = []
    operands = [
        OPERAND_TYPES[89],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xC6, 0) +
          add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vgatherpf1dpd: vm32y{k}
    forms << Form.new(operands, encodings)
    VGATHERPF1DPD = Instruction.new("VGATHERPF1DPD", forms)
  end
end
