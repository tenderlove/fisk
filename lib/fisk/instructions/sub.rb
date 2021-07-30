# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SUB
    forms = []
    operands = [
        OPERAND_TYPES[0],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x2C, 0) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # subb: al, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[2],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # subb: r8, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[2],
        OPERAND_TYPES[3],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
          add_opcode(buffer, 0x28, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
          add_opcode(buffer, 0x2A, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subb: r8, r8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[2],
        OPERAND_TYPES[4],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
          add_opcode(buffer, 0x2A, 0) +
          add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subb: r8, m8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[5],
        OPERAND_TYPES[6],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0x66, false) +
          add_opcode(buffer, 0x2D, 0) +
          add_immediate(buffer, operands[1].op_value, 2) +
          0
        end
      }.new.freeze,
    ].freeze
    # subw: ax, imm16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[7],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # subw: r16, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[7],
        OPERAND_TYPES[6],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 2) +
          0
        end
      }.new.freeze,
    ].freeze
    # subw: r16, imm16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[7],
        OPERAND_TYPES[8],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0x66, false) +
          add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
          add_opcode(buffer, 0x29, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0x66, false) +
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
          add_opcode(buffer, 0x2B, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subw: r16, r16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[7],
        OPERAND_TYPES[9],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0x66, false) +
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
          add_opcode(buffer, 0x2B, 0) +
          add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subw: r16, m16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[10],
        OPERAND_TYPES[11],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_opcode(buffer, 0x2D, 0) +
          add_immediate(buffer, operands[1].op_value, 4) +
          0
        end
      }.new.freeze,
    ].freeze
    # subl: eax, imm32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # subl: r32, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[11],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 4) +
          0
        end
      }.new.freeze,
    ].freeze
    # subl: r32, imm32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[13],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
          add_opcode(buffer, 0x29, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
          add_opcode(buffer, 0x2B, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subl: r32, r32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[12],
        OPERAND_TYPES[14],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
          add_opcode(buffer, 0x2B, 0) +
          add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subl: r32, m32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[15],
        OPERAND_TYPES[11],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              0) +
          add_opcode(buffer, 0x2D, 0) +
          add_immediate(buffer, operands[1].op_value, 4) +
          0
        end
      }.new.freeze,
    ].freeze
    # subq: rax, imm32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # subq: r64, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
        OPERAND_TYPES[11],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 4) +
          0
        end
      }.new.freeze,
    ].freeze
    # subq: r64, imm32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
        OPERAND_TYPES[17],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              0,
              operands[0].rex_value) +
          add_opcode(buffer, 0x29, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              0,
              operands[1].rex_value) +
          add_opcode(buffer, 0x2B, 0) +
          add_modrm_reg_reg(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subq: r64, r64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[16],
        OPERAND_TYPES[18],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              true,
              1,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value) +
          add_opcode(buffer, 0x2B, 0) +
          add_modrm_reg_mem(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subq: r64, m64
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[19],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # subb: m8, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[19],
        OPERAND_TYPES[3],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
          add_opcode(buffer, 0x28, 0) +
          add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subb: m8, r8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[20],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # subw: m16, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[20],
        OPERAND_TYPES[6],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 2) +
          0
        end
      }.new.freeze,
    ].freeze
    # subw: m16, imm16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[20],
        OPERAND_TYPES[8],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_prefix(buffer, operands, 0x66, false) +
          add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
          add_opcode(buffer, 0x29, 0) +
          add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subw: m16, r16
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[21],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # subl: m32, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[21],
        OPERAND_TYPES[11],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 4) +
          0
        end
      }.new.freeze,
    ].freeze
    # subl: m32, imm32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[21],
        OPERAND_TYPES[13],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
          add_opcode(buffer, 0x29, 0) +
          add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subl: m32, r32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[22],
        OPERAND_TYPES[1],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 1) +
          0
        end
      }.new.freeze,
    ].freeze
    # subq: m64, imm8
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[22],
        OPERAND_TYPES[11],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
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
              5,
              operands[0].op_value, operands) +
          add_immediate(buffer, operands[1].op_value, 4) +
          0
        end
      }.new.freeze,
    ].freeze
    # subq: m64, imm32
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[22],
        OPERAND_TYPES[17],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value) +
          add_opcode(buffer, 0x29, 0) +
          add_modrm_mem_reg(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # subq: m64, r64
    forms << Form.new(operands, encodings)
    SUB = Instruction.new("SUB", forms)
  end
end
