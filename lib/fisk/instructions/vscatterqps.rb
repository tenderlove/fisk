# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSCATTERQPS
    forms = []
    operands = []
    encodings = []
    # vscatterqps: vm64x{k}, xmm
    operands << OPERAND_TYPES[106]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xA3, 0
        add_modrm(buffer, operands,
              0,
              operands[1].op_value,
              operands[0].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vscatterqps: vm64y{k}, xmm
    operands << OPERAND_TYPES[107]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xA3, 0
        add_modrm(buffer, operands,
              0,
              operands[1].op_value,
              operands[0].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vscatterqps: vm64z{k}, ymm
    operands << OPERAND_TYPES[108]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xA3, 0
        add_modrm(buffer, operands,
              0,
              operands[1].op_value,
              operands[0].op_value)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VSCATTERQPS = Instruction.new("VSCATTERQPS", forms)
  end
end
