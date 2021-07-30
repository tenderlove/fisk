# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BEXTR
    forms = []
    operands = []
    encodings = []
    # bextr: r32, r32, imm32
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x10, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 4) +
        0
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # bextr: r32, r32, r32
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xF7, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # bextr: r32, m32, imm32
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[14]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x10, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 4) +
        0
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # bextr: r32, m32, r32
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[14]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xF7, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # bextr: r64, r64, imm32
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x10, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 4) +
        0
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # bextr: r64, r64, r64
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xF7, 0) +
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # bextr: r64, m64, imm32
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[18]
    operands << OPERAND_TYPES[11]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0x10, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        add_immediate(buffer, operands[2].op_value, 4) +
        0
      end

      def bytesize; 6; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # bextr: r64, m64, r64
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[18]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX(buffer, operands)
        add_opcode(buffer, 0xF7, 0) +
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands) +
        0
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    BEXTR = Instruction.new("BEXTR", forms)
  end
end
