# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSCATTERPF0QPS
    forms = []
    operands = []
    encodings = []
    # vscatterpf0qps: vm64z{k}
    operands << OPERAND_TYPES[91]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0xC7, 0) +
        add_modrm(buffer,
              0,
              5,
              operands[0].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VSCATTERPF0QPS = Instruction.new("VSCATTERPF0QPS", forms)
  end
end
