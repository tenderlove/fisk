require "helper"
require_relative "test_fisk"

class Fisk
  class FiskSizeTest < FiskTest
    class CheckWrittenSize < Fisk
      private

      def write_instruction insn, buffer, labels
        pos = buffer.pos
        x = insn.encode buffer, labels
        raise unless x == buffer.pos - pos
      end
    end

    def setup
      super
      @fisk = CheckWrittenSize.new
    end
  end
end
