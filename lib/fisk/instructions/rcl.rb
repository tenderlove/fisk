# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction RCL
    forms = []
    operands = []
    encodings = []
    # rclb: r8, 1
    operands << OPERAND_TYPES[2]
    operands << OPERAND_TYPES[55]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD0, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rclb: r8, imm8
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
        add_opcode(buffer, 0xC0, 0) +
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
    # rclb: r8, cl
    operands << OPERAND_TYPES[2]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD2, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rclw: r16, 1
    operands << OPERAND_TYPES[7]
    operands << OPERAND_TYPES[55]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD1, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rclw: r16, imm8
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
        add_opcode(buffer, 0xC1, 0) +
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
    # rclw: r16, cl
    operands << OPERAND_TYPES[7]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD3, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rcll: r32, 1
    operands << OPERAND_TYPES[12]
    operands << OPERAND_TYPES[55]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD1, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rcll: r32, imm8
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
        add_opcode(buffer, 0xC1, 0) +
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
    # rcll: r32, cl
    operands << OPERAND_TYPES[12]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD3, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rclq: r64, 1
    operands << OPERAND_TYPES[16]
    operands << OPERAND_TYPES[55]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD1, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rclq: r64, imm8
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
        add_opcode(buffer, 0xC1, 0) +
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
    # rclq: r64, cl
    operands << OPERAND_TYPES[16]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD3, 0) +
        add_modrm(buffer,
              3,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rclb: m8, 1
    operands << OPERAND_TYPES[19]
    operands << OPERAND_TYPES[55]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD0, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rclb: m8, imm8
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
        add_opcode(buffer, 0xC0, 0) +
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
    # rclb: m8, cl
    operands << OPERAND_TYPES[19]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD2, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rclw: m16, 1
    operands << OPERAND_TYPES[20]
    operands << OPERAND_TYPES[55]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD1, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rclw: m16, imm8
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
        add_opcode(buffer, 0xC1, 0) +
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
    # rclw: m16, cl
    operands << OPERAND_TYPES[20]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix(buffer, operands, 0x66, false) +
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD3, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rcll: m32, 1
    operands << OPERAND_TYPES[21]
    operands << OPERAND_TYPES[55]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD1, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rcll: m32, imm8
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
        add_opcode(buffer, 0xC1, 0) +
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
    # rcll: m32, cl
    operands << OPERAND_TYPES[21]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD3, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rclq: m64, 1
    operands << OPERAND_TYPES[22]
    operands << OPERAND_TYPES[55]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD1, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # rclq: m64, imm8
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
        add_opcode(buffer, 0xC1, 0) +
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
    # rclq: m64, cl
    operands << OPERAND_TYPES[22]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              operands[0].rex_value,
              operands[0].rex_value) +
        add_opcode(buffer, 0xD3, 0) +
        add_modrm(buffer,
              0,
              2,
              operands[0].op_value, operands) +
        0
      end
    }.new
    forms << Form.new(operands, encodings)
    RCL = Instruction.new("RCL", forms)
  end
end
