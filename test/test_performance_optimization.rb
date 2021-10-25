require "helper"

class Fisk
  class PerformanceOptimizationTest < Fisk::Test
    include Registers

    attr_reader :fisk

    def setup
      super
      @fisk = Fisk.new performance: :optimize
    end

    def test_no_change
      buf = StringIO.new(''.b)

      fisk.mov R9, R10

      fisk.write_to buf

      # The binary string represents the unchanged instruction.
      #
      assert_equal buf.string, "\x4D\x89\xD1".b
    end

    def test_remove_no_op_instruction
      buf = StringIO.new(''.b)

      fisk.mov R9, R9

      fisk.write_to buf

      assert_equal buf.string, "".b
    end
  end
end
