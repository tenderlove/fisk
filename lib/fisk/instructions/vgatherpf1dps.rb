# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERPF1DPS
    forms = []
    operands = []
    encodings = []
    # vgatherpf1dps: vm32z{k}
    operands << OPERAND_TYPES[90]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xC6, 0
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VGATHERPF1DPS = Instruction.new("VGATHERPF1DPS", forms)
  end
end
