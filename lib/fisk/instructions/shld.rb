# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SHLD
    forms = []
    operands = []
    encodings = []
    # shldw: r16, r16, imm8
    operands << OPERAND_TYPES[7]
    operands << OPERAND_TYPES[8]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA4, 0
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # shldw: r16, r16, cl
    operands << OPERAND_TYPES[7]
    operands << OPERAND_TYPES[8]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA5, 0
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # shldl: r32, r32, imm8
    operands << OPERAND_TYPES[12]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA4, 0
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # shldl: r32, r32, cl
    operands << OPERAND_TYPES[12]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              0,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA5, 0
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # shldq: r64, r64, imm8
    operands << OPERAND_TYPES[16]
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              0,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA4, 0
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 5; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # shldq: r64, r64, cl
    operands << OPERAND_TYPES[16]
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              0,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA5, 0
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # shldw: m16, r16, imm8
    operands << OPERAND_TYPES[20]
    operands << OPERAND_TYPES[8]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA4, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # shldw: m16, r16, cl
    operands << OPERAND_TYPES[20]
    operands << OPERAND_TYPES[8]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA5, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # shldl: m32, r32, imm8
    operands << OPERAND_TYPES[21]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA4, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # shldl: m32, r32, cl
    operands << OPERAND_TYPES[21]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA5, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # shldq: m64, r64, imm8
    operands << OPERAND_TYPES[22]
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA4, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 5; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # shldq: m64, r64, cl
    operands << OPERAND_TYPES[22]
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[56]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              operands[1].rex_value,
              operands[0].rex_value,
              operands[0].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xA5, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    SHLD = Instruction.new("SHLD", forms)
  end
end
