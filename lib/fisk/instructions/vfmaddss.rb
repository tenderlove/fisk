# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VFMADDSS
    forms = []
    operands = []
    encodings = []
    # vfmaddss: xmm, xmm, xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x6A, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[3].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x6A, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vfmaddss: xmm, xmm, xmm, m32
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x6A, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[3].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vfmaddss: xmm, xmm, m32, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[14]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x6A, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VFMADDSS = Instruction.new("VFMADDSS", forms)
  end
end
