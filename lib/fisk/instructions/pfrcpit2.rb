# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PFRCPIT2
    forms = []
    operands = []
    encodings = []
    # pfrcpit2: mm, mm
    operands << OPERAND_TYPES[54]
    operands << OPERAND_TYPES[36]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              0,
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer, operands,
              3,
              operands[0].value,
              operands[1].value)
        add_opcode buffer, 0xB6, 0
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # pfrcpit2: mm, m64
    operands << OPERAND_TYPES[54]
    operands << OPERAND_TYPES[18]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              (operands[0].value >> 3),
              (operands[1].value >> 3),
              (operands[1].value >> 3))
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer, operands,
              0,
              operands[0].value,
              operands[1].value)
        add_opcode buffer, 0xB6, 0
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    PFRCPIT2 = Instruction.new("PFRCPIT2", forms)
  end
end
