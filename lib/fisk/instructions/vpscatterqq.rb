# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VPSCATTERQQ
    forms = []
    operands = [
        OPERAND_TYPES[106],
        OPERAND_TYPES[24],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xA1, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpscatterqq: vm64x{k}, xmm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[107],
        OPERAND_TYPES[60],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xA1, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpscatterqq: vm64y{k}, ymm
    forms << Form.new(operands, encodings)
    operands = [
        OPERAND_TYPES[108],
        OPERAND_TYPES[63],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xA1, 0) +
          add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vpscatterqq: vm64z{k}, zmm
    forms << Form.new(operands, encodings)
    VPSCATTERQQ = Instruction.new("VPSCATTERQQ", forms)
  end
end
