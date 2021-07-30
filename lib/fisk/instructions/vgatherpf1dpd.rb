# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERPF1DPD
    VGATHERPF1DPD = Instruction.new("VGATHERPF1DPD", [
    # vgatherpf1dpd: vm32y{k}
      Form.new([
        OPERAND_TYPES[89],
      ].freeze, [
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
      ].freeze).freeze,
    ].freeze).freeze
  end
end
