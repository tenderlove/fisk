# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPOPCNTQ
    forms = []
    operands = []
    encodings = []
    # vpopcntq: zmm{k}{z}, m512/m64bcst
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[64]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x55, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpopcntq: zmm{k}{z}, zmm
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x55, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VPOPCNTQ = Instruction.new("VPOPCNTQ", forms)
  end
end
