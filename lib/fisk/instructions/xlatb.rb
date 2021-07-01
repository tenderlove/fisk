# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction XLATB
    forms = []
    operands = []
    encodings = []
    # xlatb: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_opcode buffer, 0xD7, 0
      end

      def bytesize; 1; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    operands = []
    encodings = []
    # xlatb: 
    encodings << Class.new(Fisk::Machine::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              true,
              1,
              0,
              0,
              0)
        add_opcode buffer, 0xD7, 0
      end

      def bytesize; 2; end
    }.new
    forms << Fisk::Machine::Form.new(operands, encodings)
    XLATB = Fisk::Machine::Instruction.new("XLATB", forms)
  end
end
