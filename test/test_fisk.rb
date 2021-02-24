require "fisk"
require "crabstone"
require "minitest/autorun"

class FiskTest < Minitest::Test
  attr_reader :fisk

  def setup
    super
    @fisk = Fisk.new
  end

  def test_lol
    binary = fisk.asm do
      push rbp
      mov rsp, rbp
      int lit(3)
      pop rbp
      ret
    end
    assert_equal "UH\x89\xEC\xCC]\xC3".b, binary
  end

  def test_add_eax
    fisk.add fisk.eax, fisk.imm32(0x4351ff23)
    i = disasm(fisk.to_binary).first
    assert_equal "add", i.mnemonic.to_s
    assert_equal "eax, 0x4351ff23", i.op_str.to_s
  end

  def test_add_ecx_esi
    fisk.add fisk.ecx, fisk.esi
    i = disasm(fisk.to_binary).first
    assert_equal "add", i.mnemonic.to_s
    assert_equal "ecx, esi", i.op_str.to_s
  end

  def test_add_rcx_rsi
    fisk.add fisk.rcx, fisk.rsi
    i = disasm(fisk.to_binary).first
    assert_equal "add", i.mnemonic.to_s
    assert_equal "rcx, rsi".b, i.op_str.to_s.b
  end

  def test_add_rax
    fisk.add fisk.rax, fisk.imm32(0x4351ff23)
    i = disasm(fisk.to_binary).first
    assert_equal "add", i.mnemonic.to_s
    assert_equal "rax, 0x4351ff23", i.op_str.to_s
  end

  def test_add_rax_rcx
    fisk.add fisk.rax, fisk.rcx
    i = disasm(fisk.to_binary).first
    assert_equal "add", i.mnemonic.to_s
    assert_equal "rax, rcx", i.op_str.to_s
  end

  def test_add_rcx_r9
    fisk.add fisk.rcx, fisk.r9
    i = disasm(fisk.to_binary).first
    assert_equal "add", i.mnemonic.to_s
    assert_equal "rcx, r9", i.op_str.to_s
  end

  def test_adc_rcx_r9
    fisk.adc fisk.rcx, fisk.r9
    i = disasm(fisk.to_binary).first
    assert_equal "adc", i.mnemonic.to_s
    assert_equal "rcx, r9", i.op_str.to_s
  end

  def test_int3
    fisk.int fisk.lit(3)
    i = disasm(fisk.to_binary).first
    assert_equal "int3", i.mnemonic.to_s
    assert_equal "", i.op_str.to_s
  end

  def test_int5
    fisk.int fisk.imm8(5)
    i = disasm(fisk.to_binary).first
    assert_equal "int", i.mnemonic.to_s
    assert_equal "5", i.op_str.to_s
  end

  def test_push_rbp
    fisk.push fisk.rbp
    i = disasm(fisk.to_binary).first
    assert_equal "push", i.mnemonic.to_s
    assert_equal "rbp", i.op_str.to_s
  end

  def test_mov_rsp_rbp
    fisk.mov fisk.rsp, fisk.rbp
    i = disasm(fisk.to_binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "rsp, rbp", i.op_str.to_s
  end

  def test_popq
    fisk.pop fisk.rbp
    i = disasm(fisk.to_binary).first
    assert_equal "pop", i.mnemonic.to_s
    assert_equal "rbp", i.op_str.to_s
  end

  def test_ret
    fisk.ret
    i = disasm(fisk.to_binary).first
    assert_equal "ret", i.mnemonic.to_s
  end

  def disasm binary
    cs = Crabstone::Disassembler.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    cs.disasm binary, 0
  end
end
