# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPCMOV
    forms = []
    operands = []
    encodings = []
    # vpcmov: xmm, xmm, xmm, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xA2, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xA2, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[3].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpcmov: xmm, xmm, xmm, m128
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xA2, 0
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
    # vpcmov: xmm, xmm, m128, xmm
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[24]
    operands << OPERAND_TYPES[25]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xA2, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpcmov: ymm, ymm, ymm, ymm
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xA2, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xA2, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[3].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpcmov: ymm, ymm, ymm, m256
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xA2, 0
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
    # vpcmov: ymm, ymm, m256, ymm
    operands << OPERAND_TYPES[65]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[66]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xA2, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[2].op_value, operands)
        add_RegisterByte buffer, operands
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VPCMOV = Instruction.new("VPCMOV", forms)
  end
end
