# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPMOVM2B
    forms = []
    operands = []
    encodings = []
    # vpmovm2b: xmm, k
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x28, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovm2b: ymm, k
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x28, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovm2b: zmm, k
    operands << OPERAND_TYPES[97]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x28, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VPMOVM2B = Instruction.new("VPMOVM2B", forms)
  end
end
