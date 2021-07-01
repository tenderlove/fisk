# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSCATTERPF0QPS
    forms = []
    operands = []
    encodings = []
    # vscatterpf0qps: vm64z{k}
    operands << OPERAND_TYPES[91]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xC7, 0
        add_modrm(buffer, operands,
              0,
              5,
              operands[0].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    VSCATTERPF0QPS = Fisk::Machine::Instruction.new("VSCATTERPF0QPS", forms)
  end
end
