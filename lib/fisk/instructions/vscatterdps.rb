# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VSCATTERDPS
    forms = []
    operands = [
        OPERAND_TYPES[103],
        OPERAND_TYPES[24],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xA2, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vscatterdps: vm32x{k}, xmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[104],
        OPERAND_TYPES[60],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xA2, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vscatterdps: vm32y{k}, ymm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[105],
        OPERAND_TYPES[63],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xA2, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vscatterdps: vm32z{k}, zmm
    forms << Form.new(operands, encodings)
    VSCATTERDPS = Instruction.new("VSCATTERDPS", forms)
  end
end
