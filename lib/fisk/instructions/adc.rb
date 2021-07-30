# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction ADC
    forms = []
    operands = []
    encodings = []
    # adcb: al, imm8
    operands << OPERAND_TYPES[0]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x14, 0) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcb: r8, imm8
    operands << OPERAND_TYPES[2]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x80, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcb: r8, r8
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
        add_opcode(buffer, 0x10, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
        add_opcode(buffer, 0x12, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcb: r8, m8
    operands << OPERAND_TYPES[2]
    operands << OPERAND_TYPES[4]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
        add_opcode(buffer, 0x12, 0) +
        add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcw: ax, imm16
    operands << OPERAND_TYPES[5]
    operands << OPERAND_TYPES[6]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_opcode(buffer, 0x15, 0) +
        add_immediate(buffer, operands[1].op_value, 2) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcw: r16, imm8
    operands << OPERAND_TYPES[7]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x83, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcw: r16, imm16
    operands << OPERAND_TYPES[7]
    operands << OPERAND_TYPES[6]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x81, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 2) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcw: r16, r16
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
        add_opcode(buffer, 0x11, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
        add_opcode(buffer, 0x13, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcw: r16, m16
    operands << OPERAND_TYPES[7]
    operands << OPERAND_TYPES[9]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
        add_opcode(buffer, 0x13, 0) +
        add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcl: eax, imm32
    operands << OPERAND_TYPES[10]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0x15, 0) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcl: r32, imm8
    operands << OPERAND_TYPES[12]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x83, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcl: r32, imm32
    operands << OPERAND_TYPES[12]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x81, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcl: r32, r32
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
        add_opcode(buffer, 0x11, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
        add_opcode(buffer, 0x13, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcl: r32, m32
    operands << OPERAND_TYPES[12]
    operands << OPERAND_TYPES[14]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
        add_opcode(buffer, 0x13, 0) +
        add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcq: rax, imm32
    operands << OPERAND_TYPES[15]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              0) +
        add_opcode(buffer, 0x15, 0) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcq: r64, imm8
    operands << OPERAND_TYPES[16]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x83, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcq: r64, imm32
    operands << OPERAND_TYPES[16]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x81, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcq: r64, r64
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
        add_opcode(buffer, 0x11, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
        add_opcode(buffer, 0x13, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcq: r64, m64
    operands << OPERAND_TYPES[16]
    operands << OPERAND_TYPES[18]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
        add_opcode(buffer, 0x13, 0) +
        add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcb: m8, imm8
    operands << OPERAND_TYPES[19]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x80, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcb: m8, r8
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
        add_opcode(buffer, 0x10, 0) +
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
    # adcw: m16, imm8
    operands << OPERAND_TYPES[20]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x83, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcw: m16, imm16
    operands << OPERAND_TYPES[20]
    operands << OPERAND_TYPES[6]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x81, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 2) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcw: m16, r16
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
        add_opcode(buffer, 0x11, 0) +
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
    # adcl: m32, imm8
    operands << OPERAND_TYPES[21]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x83, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcl: m32, imm32
    operands << OPERAND_TYPES[21]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x81, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcl: m32, r32
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
        add_opcode(buffer, 0x11, 0) +
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
    # adcq: m64, imm8
    operands << OPERAND_TYPES[22]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x83, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcq: m64, imm32
    operands << OPERAND_TYPES[22]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x81, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # adcq: m64, r64
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
        add_opcode(buffer, 0x11, 0) +
        add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    ADC = Instruction.new("ADC", forms)
  end
end
