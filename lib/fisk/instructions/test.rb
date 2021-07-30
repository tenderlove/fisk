# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction TEST
    forms = []
    operands = []
    encodings = []
    # testb: al, imm8
    operands << OPERAND_TYPES[31]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0xA8, 0) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testb: r8, imm8
    operands << OPERAND_TYPES[3]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0xF6, 0) +
        add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testb: r8, r8
    operands << OPERAND_TYPES[3]
    operands << OPERAND_TYPES[3]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x84, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testw: ax, imm16
    operands << OPERAND_TYPES[32]
    operands << OPERAND_TYPES[6]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_opcode(buffer, 0xA9, 0) +
        add_immediate(buffer, operands[1].op_value, 2) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testw: r16, imm16
    operands << OPERAND_TYPES[8]
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
        add_opcode(buffer, 0xF7, 0) +
        add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 2) +
        0
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testw: r16, r16
    operands << OPERAND_TYPES[8]
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
        add_opcode(buffer, 0x85, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testl: eax, imm32
    operands << OPERAND_TYPES[33]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_opcode(buffer, 0xA9, 0) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end

      def bytesize; 5; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testl: r32, imm32
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0xF7, 0) +
        add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testl: r32, r32
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x85, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testq: rax, imm32
    operands << OPERAND_TYPES[34]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              0) +
        add_opcode(buffer, 0xA9, 0) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testq: r64, imm32
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0xF7, 0) +
        add_modrm(buffer,
              3,
              0,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end

      def bytesize; 7; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testq: r64, r64
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0x85, 0) +
        add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testb: m8, imm8
    operands << OPERAND_TYPES[4]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0xF6, 0) +
        add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 1) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testb: m8, r8
    operands << OPERAND_TYPES[4]
    operands << OPERAND_TYPES[3]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x84, 0) +
        add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testw: m16, imm16
    operands << OPERAND_TYPES[9]
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
        add_opcode(buffer, 0xF7, 0) +
        add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 2) +
        0
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testw: m16, r16
    operands << OPERAND_TYPES[9]
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
        add_opcode(buffer, 0x85, 0) +
        add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testl: m32, imm32
    operands << OPERAND_TYPES[14]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0xF7, 0) +
        add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testl: m32, r32
    operands << OPERAND_TYPES[14]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x85, 0) +
        add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testq: m64, imm32
    operands << OPERAND_TYPES[18]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0xF7, 0) +
        add_modrm(buffer,
              0,
              0,
              operands[0].op_value, operands) +
        add_immediate(buffer, operands[1].op_value, 4) +
        0
      end

      def bytesize; 7; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # testq: m64, r64
    operands << OPERAND_TYPES[18]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0x85, 0) +
        add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
        0
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    TEST = Instruction.new("TEST", forms)
  end
end
