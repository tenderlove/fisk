# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPSCATTERDQ
    forms = []
    operands = []
    encodings = []
    # vpscatterdq: vm32x{k}, xmm
    operands << OPERAND_TYPES[103]
    operands << OPERAND_TYPES[24]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xA0, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpscatterdq: vm32x{k}, ymm
    operands << OPERAND_TYPES[103]
    operands << OPERAND_TYPES[60]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xA0, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vpscatterdq: vm32y{k}, zmm
    operands << OPERAND_TYPES[104]
    operands << OPERAND_TYPES[63]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xA0, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VPSCATTERDQ = Instruction.new("VPSCATTERDQ", forms)
  end
end
