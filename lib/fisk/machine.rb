class Fisk
  class Machine
    Instructions = {}

    Operand = Struct.new :type

    def self.instructions
      Instructions
    end

    def self.instruction_with_name name
      Instructions[name]
    end

    class Form
      attr_reader :operands, :encodings

      def initialize operands, encodings
        @operands = operands
        @encodings = encodings
      end
    end

    class Instruction
      attr_reader :name, :forms

      def initialize name, forms
        @name = name
        @forms = forms
      end
    end
  end
end

require "fisk/machine/generated"
