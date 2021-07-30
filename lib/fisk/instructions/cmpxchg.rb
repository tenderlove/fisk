# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction CMPXCHG
    forms = []
    operands = []
    encodings = []
    # cmpxchgb: r8, r8
    operands << OPERAND_TYPES[2]
    operands << OPERAND_TYPES[3]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0xB0, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # cmpxchgw: r16, r16
    operands << OPERAND_TYPES[7]
    operands << OPERAND_TYPES[8]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0xB1, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # cmpxchgl: r32, r32
    operands << OPERAND_TYPES[12]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0xB1, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # cmpxchgq: r64, r64
    operands << OPERAND_TYPES[16]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0xB1, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # cmpxchgb: m8, r8
    operands << OPERAND_TYPES[19]
    operands << OPERAND_TYPES[3]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0xB0, 0) +
        add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # cmpxchgw: m16, r16
    operands << OPERAND_TYPES[20]
    operands << OPERAND_TYPES[8]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0xB1, 0) +
        add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # cmpxchgl: m32, r32
    operands << OPERAND_TYPES[21]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0xB1, 0) +
        add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # cmpxchgq: m64, r64
    operands << OPERAND_TYPES[22]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x0F, 0) +
        add_opcode(buffer, 0xB1, 0) +
        add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    CMPXCHG = Instruction.new("CMPXCHG", forms)
  end
end
