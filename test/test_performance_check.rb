require "helper"

class Fisk
  class PerformanceCheckTest < Fisk::Test
    include Registers

    attr_reader :fisk

    def setup
      super
      @fisk = Fisk.new check_performance: true
    end

    def test_mov_same_register
      buf = StringIO.new(''.b)

      fisk.mov R9, R9
      fisk.mov RAX, RAX

      error = assert_raises Errors::SuboptimalPerformance do
        fisk.write_to buf
      end

      expected_warnings = [
        "MOV with same register (r9)",
        "MOV with same register (rax)",
      ]

      assert_equal error.warnings, expected_warnings
    end
  end
end
