class Fisk
  class Machine
    def self.instruction_with_name name
      Instructions.const_get name
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
