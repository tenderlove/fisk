# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSCATTERPF0DPS
    forms = []
    operands = []
    encodings = []
    # vscatterpf0dps: vm32z{k}
    operands << OPERAND_TYPES[90]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xC6, 0
        add_modrm(buffer, operands,
              0,
              5,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VSCATTERPF0DPS = Fisk::Machine::Instruction.new("VSCATTERPF0DPS", forms)
  end
end
