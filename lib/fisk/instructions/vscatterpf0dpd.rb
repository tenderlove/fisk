# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSCATTERPF0DPD
    forms = []
    operands = []
    encodings = []
    # vscatterpf0dpd: vm32y{k}
    operands << OPERAND_TYPES[89]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xC6, 0
        add_modrm(buffer, operands,
              0,
              5,
              operands[0].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VSCATTERPF0DPD = Instruction.new("VSCATTERPF0DPD", forms)
  end
end
