require "fisk"
require "crabstone"

ENV["MT_NO_PLUGINS"] = "1"
require "minitest/autorun"

class Fisk::Test < Minitest::Test
  def print_disasm binary
    cs = Crabstone::Disassembler.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    cs.disasm(binary, 0x0000).each {|i|
      printf("0x%x:\t%s\t\t%s\n",i.address, i.mnemonic, i.op_str)
    }
  end
end
