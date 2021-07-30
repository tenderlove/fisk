# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VGATHERPF0QPS
    forms = []
    operands = [
        OPERAND_TYPES[91],
    ].freeze
    encodings = [
      Class.new(Fisk::Encoding) {
        def encode buffer, operands
          add_EVEX(buffer, operands)
          add_opcode(buffer, 0xC7, 0) +
          add_modrm(buffer,
              0,
              1,
              operands[0].op_value, operands) +
          0
        end
      }.new.freeze,
    ].freeze
    # vgatherpf0qps: vm64z{k}
    forms << Form.new(operands, encodings)
    VGATHERPF0QPS = Instruction.new("VGATHERPF0QPS", forms)
  end
end
