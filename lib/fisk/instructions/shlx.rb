# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction SHLX
    forms = []
    operands = []
    encodings = []
    # shlxl: r32, r32, r32
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[13]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xF7, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # shlxl: r32, m32, r32
    operands << OPERAND_TYPES[27]
    operands << OPERAND_TYPES[14]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xF7, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # shlxq: r64, r64, r64
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[17]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xF7, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # shlxq: r64, m64, r64
    operands << OPERAND_TYPES[28]
    operands << OPERAND_TYPES[18]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0xF7, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    SHLX = Fisk::Machine::Instruction.new("SHLX", forms)
  end
end
