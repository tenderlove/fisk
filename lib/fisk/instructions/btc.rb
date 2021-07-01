# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction BTC
    forms = []
    operands = []
    encodings = []
    # btcw: r16, imm8
    operands << OPERAND_TYPES[7]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBA, 0
        add_modrm(buffer, operands,
              3,
              7,
              operands[0].value)
        add_immediate buffer, operands[1].value, 1
      end

      def bytesize; 4; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # btcw: r16, r16
    operands << OPERAND_TYPES[7]
    operands << OPERAND_TYPES[8]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_rex(buffer, operands,
              false,
              0,
              (operands[1].value >> 3),
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBB, 0
        add_modrm(buffer, operands,
              3,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # btcl: r32, imm8
    operands << OPERAND_TYPES[12]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBA, 0
        add_modrm(buffer, operands,
              3,
              7,
              operands[0].value)
        add_immediate buffer, operands[1].value, 1
      end

      def bytesize; 4; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # btcl: r32, r32
    operands << OPERAND_TYPES[12]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[1].value >> 3),
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBB, 0
        add_modrm(buffer, operands,
              3,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # btcq: r64, imm8
    operands << OPERAND_TYPES[16]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBA, 0
        add_modrm(buffer, operands,
              3,
              7,
              operands[0].value)
        add_immediate buffer, operands[1].value, 1
      end

      def bytesize; 5; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # btcq: r64, r64
    operands << OPERAND_TYPES[16]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              (operands[1].value >> 3),
              0,
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBB, 0
        add_modrm(buffer, operands,
              3,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 4; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # btcw: m16, imm8
    operands << OPERAND_TYPES[20]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_rex(buffer, operands,
              false,
              0,
              0,
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBA, 0
        add_modrm(buffer, operands,
              0,
              7,
              operands[0].value)
        add_immediate buffer, operands[1].value, 1
      end

      def bytesize; 4; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # btcw: m16, r16
    operands << OPERAND_TYPES[20]
    operands << OPERAND_TYPES[8]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_prefix buffer, operands, 0x66, false
        add_rex(buffer, operands,
              false,
              0,
              (operands[1].value >> 3),
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBB, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # btcl: m32, imm8
    operands << OPERAND_TYPES[21]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              0,
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBA, 0
        add_modrm(buffer, operands,
              0,
              7,
              operands[0].value)
        add_immediate buffer, operands[1].value, 1
      end

      def bytesize; 4; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # btcl: m32, r32
    operands << OPERAND_TYPES[21]
    operands << OPERAND_TYPES[13]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[1].value >> 3),
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBB, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 3; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # btcq: m64, imm8
    operands << OPERAND_TYPES[22]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBA, 0
        add_modrm(buffer, operands,
              0,
              7,
              operands[0].value)
        add_immediate buffer, operands[1].value, 1
      end

      def bytesize; 5; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # btcq: m64, r64
    operands << OPERAND_TYPES[22]
    operands << OPERAND_TYPES[17]
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              (operands[1].value >> 3),
              (operands[0].value >> 3),
              (operands[0].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0xBB, 0
        add_modrm(buffer, operands,
              0,
              operands[1].value,
              operands[0].value)
      end

      def bytesize; 4; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    BTC = Fisk::Machine::Instruction.new("BTC", forms)
  end
end
