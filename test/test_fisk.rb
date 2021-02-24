require "fisk"
require "crabstone"
require "minitest/autorun"

class FiskTest < Minitest::Test
  def test_add_eax
    fisk = Fisk.new
    fisk.add fisk.eax, fisk.imm32(0x4351ff23)
    i = disasm(fisk.to_binary).first
    assert_equal "add", i.mnemonic.to_s
    assert_equal "eax, 0x4351ff23", i.op_str.to_s
  end

  def test_add_ecx_esi
    fisk = Fisk.new
    fisk.add fisk.ecx, fisk.esi
    i = disasm(fisk.to_binary).first
    assert_equal "add", i.mnemonic.to_s
    assert_equal "ecx, esi", i.op_str.to_s
  end

  def test_add_rcx_rsi
    fisk = Fisk.new
    fisk.add fisk.rcx, fisk.rsi
    i = disasm(fisk.to_binary).first
    assert_equal "add", i.mnemonic.to_s
    assert_equal "rcx, rsi".b, i.op_str.to_s.b
  end

  def test_add_rax
    fisk = Fisk.new
    fisk.add fisk.rax, fisk.imm32(0x4351ff23)
    i = disasm(fisk.to_binary).first
    assert_equal "add", i.mnemonic.to_s
    assert_equal "rax, 0x4351ff23", i.op_str.to_s
  end

  def disasm binary
    cs = Crabstone::Disassembler.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    cs.disasm binary, 0
  end
end
