# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VFNMADDSS
    forms = []
    operands = []
    encodings = []
    # vfnmaddss: xmm, xmm, xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x7A, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[3].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x7A, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[2].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vfnmaddss: xmm, xmm, xmm, m32
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x7A, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[3].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vfnmaddss: xmm, xmm, m32, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[14]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x7A, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[2].value)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VFNMADDSS = Instruction.new("VFNMADDSS", forms)
  end
end
