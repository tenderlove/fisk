# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERPF0DPD
    forms = []
    operands = []
    encodings = []
    # vgatherpf0dpd: vm32y{k}
    operands << OPERAND_TYPES[89]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xC6, 0
        add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VGATHERPF0DPD = Instruction.new("VGATHERPF0DPD", forms)
  end
end
