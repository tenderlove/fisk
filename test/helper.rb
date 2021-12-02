require "fisk"
require "crabstone"

ENV["MT_NO_PLUGINS"] = "1"
require "minitest/autorun"

# https://github.com/bnagy/crabstone/issues/10
class Crabstone::Binding::Instruction
  class << self
    alias :old_release :release
  end

  # Squelch error in crabstone
  def self.release obj
    nil
  end
end

class Fisk::Test < Minitest::Test
  def print_disasm binary
    cs = Crabstone::Disassembler.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    cs.disasm(binary, 0x0000).each {|i|
      printf("0x%x:\t%s\t\t%s\n",i.address, i.mnemonic, i.op_str)
    }
  end

  def disasm binary
    cs = Crabstone::Disassembler.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    cs.disasm binary, 0
  end
end
