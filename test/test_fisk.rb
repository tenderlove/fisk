require "helper"

class FiskTest < Fisk::Test
  attr_reader :fisk

  def setup
    super
    @fisk = Fisk.new
  end

  def test_imm_casts_to_int
    [8, 16, 32, 64].each do |size|
      assert_raises do
        fisk.send("imm#{size}", Object.new)
      end
    end
  end

  def test_signed_immediate_select_imm8
    assert_equal "imm8", fisk.imm(0x7F).type
    assert_equal "imm8", fisk.imm(-0x7F - 1).type
    assert_equal "imm8", fisk.imm(0).type
  end

  def test_signed_immediate_select_imm16
    assert_equal "imm16", fisk.imm(0x7F + 1).type
    assert_equal "imm16", fisk.imm(-0x7F - 2).type

    assert_equal "imm16", fisk.imm(0x7FFF).type
    assert_equal "imm16", fisk.imm(-0x7FFF - 1).type
  end

  def test_signed_immediate_select_imm32
    assert_equal "imm32", fisk.imm(0x7FFF + 1).type
    assert_equal "imm32", fisk.imm(-0x7FFF - 2).type

    assert_equal "imm32", fisk.imm(0x7FFFFFFF).type
    assert_equal "imm32", fisk.imm(-0x7FFFFFFF - 1).type
  end

  def test_signed_immediate_select_imm64
    assert_equal "imm64", fisk.imm(0x7FFFFFFF + 1).type
    assert_equal "imm64", fisk.imm(-0x7FFFFFFF - 2).type

    assert_equal "imm64", fisk.imm(-0x7FFFFFFFFFFFFFFF - 1).type
    assert_equal "imm64", fisk.imm(0x7FFFFFFFFFFFFFFF).type
  end

  def test_signed_immediate_select_too_big
    assert_raises(ArgumentError) do
      fisk.imm(0x7FFFFFFFFFFFFFFF + 1)
    end
  end

  def test_negative_unsigned
    assert_raises(ArgumentError) do
      fisk.uimm(-0xF)
    end
  end

  def test_unsigned_immediate_select_imm8
    assert_equal "imm8", fisk.uimm(0xFF).type
    assert_equal "imm8", fisk.uimm(0).type
  end

  def test_unsigned_immediate_select_imm16
    assert_equal "imm16", fisk.uimm(0xFF + 1).type
    assert_equal "imm16", fisk.uimm(0xFFFF).type
  end

  def test_unsigned_immediate_select_imm32
    assert_equal "imm32", fisk.uimm(0xFFFF + 1).type
    assert_equal "imm32", fisk.uimm(0xFFFFFFFF).type
  end

  def test_unsigned_immediate_select_imm64
    assert_equal "imm64", fisk.uimm(0xFFFFFFFF + 1).type
    assert_equal "imm64", fisk.uimm(0xFFFFFFFFFFFFFFFF).type
  end

  def test_unsigned_immediate_too_big
    assert_raises ArgumentError do
      fisk.uimm(0xFFFFFFFFFFFFFFFF + 1)
    end
  end

  def test_write_to
    buf = StringIO.new(''.b)
    fisk.mov fisk.m64(fisk.rcx, -0xFF), fisk.rcx
    fisk.write_to buf
    i = disasm(buf.string).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "qword ptr [rcx - 0xff], rcx", i.op_str.to_s
  end

  def test_chain_methods
    fisk.jmp fisk.label(:foo)
    fisk.put_label(:foo)
    fisk.nop
    str = fisk.to_binary

    fisk = Fisk.new
    fisk.jmp(fisk.label(:foo))
      .put_label(:foo)
      .nop

    assert_equal str, fisk.to_binary
  end

  def test_lazy_labels
    fisk.jmp fisk.label(:foo)
    fisk.put_label(:foo)
    fisk.nop
    jmp, nop = disasm(fisk.to_binary)
    assert_equal "jmp", jmp.mnemonic.to_s
    assert_equal "5", jmp.op_str.to_s
    assert_equal "nop", nop.mnemonic.to_s
    assert_equal 5, nop.address
  end

  def test_read_with_edge_negative_offset
    fisk.mov fisk.m64(fisk.rcx, -0xFF), fisk.rcx
    i = disasm(fisk.to_binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "qword ptr [rcx - 0xff], rcx", i.op_str.to_s
  end

  def test_read_with_large_negative_offset
    fisk.mov fisk.m64(fisk.rcx, -0xcafe), fisk.rcx
    i = disasm(fisk.to_binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "qword ptr [rcx - 0xcafe], rcx", i.op_str.to_s
  end

  def test_read_with_negative_offset
    fisk.mov fisk.m64(fisk.rcx, -8), fisk.rcx
    i = disasm(fisk.to_binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "qword ptr [rcx - 8], rcx", i.op_str.to_s
  end

  def test_read_with_zero_offset
    fisk.mov fisk.m64(fisk.rcx), fisk.rcx
    i = disasm(fisk.to_binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "qword ptr [rcx], rcx", i.op_str.to_s
  end

  def test_read_with_non_zero_offset
    fisk.mov fisk.m64(fisk.rcx, 0xa), fisk.rcx
    i = disasm(fisk.to_binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "qword ptr [rcx + 0xa], rcx", i.op_str.to_s
  end

  def test_jmp_extended_register
    fisk.jmp fisk.r8
    i = disasm(fisk.to_binary).first
    assert_equal "jmp", i.mnemonic.to_s
    assert_equal "r8", i.op_str.to_s
  end

  def test_sub
    fisk.sub fisk.rsp, fisk.imm8(16)
    i = disasm(fisk.to_binary).first
    assert_equal "sub", i.mnemonic.to_s
    assert_equal "rsp, 0x10", i.op_str.to_s
  end

  def test_lol
    binary = fisk.asm do
      push rbp
      mov rsp, rbp
      int lit(3)
      pop rbp
      ret
    end
    assert_equal "UH\x89\xEC\xCC]\xC3".b, binary.string
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

  def test_jmp
    fisk.jmp fisk.rel32(0)
    binary = fisk.to_binary
    i = disasm(binary).first
    assert_equal "jmp", i.mnemonic.to_s
    assert_equal binary.bytesize.to_s, i.op_str.to_s
  end

  def test_jmp_rel8
    fisk.jmp fisk.rel8(-2)
    binary = fisk.to_binary
    assert_equal "\xEB\xFE".b, binary
  end

  def test_jbe_rel8
    fisk.jbe fisk.rel8(2)
    binary = fisk.to_binary
    i = disasm(binary).first
    assert_equal "jbe", i.mnemonic.to_s
    assert_equal "4", i.op_str.to_s
  end

  def test_jbe_rel32
    fisk.jbe fisk.rel32(2)
    binary = fisk.to_binary
    i = disasm(binary).first
    assert_equal "jbe", i.mnemonic.to_s
    assert_equal "8", i.op_str.to_s
  end
end
