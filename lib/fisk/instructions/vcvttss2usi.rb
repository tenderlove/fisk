# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VCVTTSS2USI
    forms = []
    operands = []
    encodings = []
    # vcvttss2usi: r32, m32
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x78, 0
        add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcvttss2usi: r64, m32
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x78, 0
        add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcvttss2usi: r32, xmm, {sae}
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[72]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x78, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vcvttss2usi: r64, xmm, {sae}
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[72]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0x78, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VCVTTSS2USI = Instruction.new("VCVTTSS2USI", forms)
  end
end
