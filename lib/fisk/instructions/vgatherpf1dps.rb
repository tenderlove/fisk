# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERPF1DPS
    VGATHERPF1DPS = Instruction.new("VGATHERPF1DPS", [
    # vgatherpf1dps: vm32z{k}
      Form.new([
        OPERAND_TYPES[90],
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
