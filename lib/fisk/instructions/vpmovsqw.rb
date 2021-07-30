# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPMOVSQW
    forms = []
    operands = []
    encodings = []
    # vpmovsqw: xmm{k}{z}, xmm
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x24, 0) +
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovsqw: m32{k}{z}, xmm
    operands << OPERAND_TYPES[101]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x24, 0) +
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovsqw: xmm{k}{z}, ymm
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x24, 0) +
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovsqw: m64{k}{z}, ymm
    operands << OPERAND_TYPES[77]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x24, 0) +
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovsqw: xmm{k}{z}, zmm
    operands << OPERAND_TYPES[57]
    operands << OPERAND_TYPES[63]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x24, 0) +
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpmovsqw: m128{k}{z}, zmm
    operands << OPERAND_TYPES[73]
    operands << OPERAND_TYPES[63]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX(buffer, operands)
        add_opcode(buffer, 0x24, 0) +
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    VPMOVSQW = Instruction.new("VPMOVSQW", forms)
  end
end
