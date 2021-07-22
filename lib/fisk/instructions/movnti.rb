# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction MOVNTI
    forms = []
    operands = []
    encodings = []
    # movntil: m32, r32
    operands << OPERAND_TYPES[37]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC3, 0
        add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # movntiq: m64, r64
    operands << OPERAND_TYPES[44]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xC3, 0
        add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    MOVNTI = Instruction.new("MOVNTI", forms)
  end
end
