# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERPF0DPS
    forms = []
    operands = []
    encodings = []
    # vgatherpf0dps: vm32z{k}
    operands << OPERAND_TYPES[90]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xC6, 0
        add_modrm(buffer, operands,
              0,
              1,
              operands[0].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VGATHERPF0DPS = Instruction.new("VGATHERPF0DPS", forms)
  end
end
