require "helper"

class FiskTest < Fisk::Test
  attr_reader :fisk

  def setup
    super
    @fisk = Fisk.new
  end

  def test_multiple_put_label_raises
    fisk.put_label(:continue)
    assert_raises Fisk::Errors::LabelAlreadyDefined do
      fisk.put_label(:continue)
    end
  end

  def test_missing_jump_label_raises
    fisk.jz(fisk.label(:continue))
    assert_raises Fisk::Errors::MissingLabel do
      fisk.to_binary
    end
  end

  def test_to_register
    assert_equal fisk.r9, fisk.r9.to_register
    temp = fisk.register
    assert_equal temp, temp.to_register
  end

  def test_immediate_predicate
    assert_predicate fisk.imm8(1), :immediate?
    refute_predicate fisk.r9, :immediate?
  end

  def test_32_memory_sizes
    fisk.mov(fisk.eax, fisk.m32(fisk.eax))
    i = disasm(fisk.to_binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "eax, dword ptr [rax]", i.op_str.to_s
  end

  def test_16_memory_sizes
    fisk.mov(fisk.ax, fisk.m16(fisk.ax))
    i = disasm(fisk.to_binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "ax, word ptr [rax]", i.op_str.to_s
  end

  def test_8_memory_sizes
    fisk.mov(fisk.al, fisk.m8(fisk.ax))
    i = disasm(fisk.to_binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "al, byte ptr [rax]", i.op_str.to_s
  end

  def test_find_compatible_instruction
    fisk.mov(fisk.r9, fisk.imm8(1))
    i = disasm(fisk.to_binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "r9, 1", i.op_str.to_s
  end

  def test_jump_target
    expected_pos = nil
    fisk.jz(fisk.label(:continue))
    fisk.mov(fisk.r9, fisk.imm64(1234))
      .jmp(fisk.r9)
      .put_label(:continue)
      .lazy { |pos| expected_pos = pos }
      .mov(fisk.r9, fisk.r10)

    i = disasm(fisk.to_binary).first
    assert_equal "je", i.mnemonic.to_s
    assert_equal sprintf("%#02x", expected_pos), i.op_str.to_s
  end

  %w{ rax rcx rdx rbx rsp rbp rsi rdi r8 r9 r10 }.each do |reg|
    define_method "test_#{reg}_to_offset" do
      fisk.lea(fisk.send(reg), fisk.rip(15))

      i = disasm(fisk.to_binary).first

      assert_equal "lea", i.mnemonic.to_s
      assert_match(/#{reg}, (?:qword ptr )?\[rip \+ 0xf\]/, i.op_str.to_s)
    end
  end

  def test_rip_to_label
    fisk.mov(fisk.rax, fisk.rip(fisk.label(:foo)))
    fisk.nop
    fisk.nop
    fisk.nop
    fisk.put_label(:foo)

    i = disasm(fisk.to_binary).first

    assert_equal "mov", i.mnemonic.to_s
    assert_equal "rax, qword ptr [rip + 3]", i.op_str.to_s
  end

  def test_m64_encoding
    fisk.mov(fisk.m64(fisk.rax, 0xf8), fisk.rax)
    i = disasm(fisk.to_binary).first

    assert_equal "mov", i.mnemonic.to_s
    assert_equal("qword ptr [rax + 0xf8], rax", i.op_str.to_s)
  end

  def test_lea_to_rip
    fisk.lea(fisk.r8, fisk.rip(2))

    i = disasm(fisk.to_binary).first

    assert_equal "lea", i.mnemonic.to_s
    assert_match(/r8, (?:qword ptr )?\[rip \+ 2\]/, i.op_str.to_s)
  end

  def test_rip_to_rax
    fisk.mov(fisk.rax, fisk.rip(2))

    i = disasm(fisk.to_binary).first

    assert_equal "mov", i.mnemonic.to_s
    assert_equal "rax, qword ptr [rip + 2]", i.op_str.to_s
  end

  def test_rax_to_rip
    fisk.mov(fisk.rip(2), fisk.rax)
    i = disasm(fisk.to_binary).first

    assert_equal "mov", i.mnemonic.to_s
    assert_equal "qword ptr [rip + 2], rax", i.op_str.to_s
  end

  def test_lea
    fisk.lea(fisk.r8, fisk.m(fisk.r9))
    lea = disasm(fisk.to_binary).first

    assert_equal "lea", lea.mnemonic.to_s
    assert_match(/r8, (?:qword ptr )?\[r9\]/, lea.op_str.to_s)
  end

  def test_lea_with_offset
    fisk.lea(fisk.r8, fisk.m(fisk.r9, 10))
    lea = disasm(fisk.to_binary).first

    assert_equal "lea", lea.mnemonic.to_s
    assert_match(/r8, (?:qword ptr )?\[r9 \+ 0xa\]/, lea.op_str.to_s)
  end

  def test_lea_with_negative_offset
    fisk.lea(fisk.r8, fisk.m(fisk.r9, -10))
    lea = disasm(fisk.to_binary).first

    assert_equal "lea", lea.mnemonic.to_s
    assert_match(/r8, (?:qword ptr )?\[r9 \- 0xa\]/, lea.op_str.to_s)
  end

  def test_lazy
    buf = StringIO.new(''.b)
    patch_location = nil
    fisk.nop
    fisk.lazy { |pos|
      patch_location = pos
    }
    fisk.nop
    fisk.lazy { |_|
      fisk.mov(fisk.r8, fisk.imm64(patch_location))
    }
    fisk.write_to buf
    assert_equal 1, patch_location
    i = disasm(buf.string).last
    assert_equal "movabs", i.mnemonic.to_s
    assert_equal "r8, 1", i.op_str.to_s
  end

  def test_super_lazy
    buf = StringIO.new(''.b)
    fisk.lazy { |_|
      fisk.mov(fisk.r8, fisk.imm64(10))
      fisk.lazy { |_|
        fisk.mov(fisk.r8, fisk.imm64(1))
      }
    }
    fisk.write_to buf
    i = disasm(buf.string).last
    assert_equal "movabs", i.mnemonic.to_s
    assert_equal "r8, 1", i.op_str.to_s
  end

  def test_super_lazy_twice
    fisk.lazy { |_|
      fisk.mov(fisk.r8, fisk.imm64(10))
      fisk.lazy { |_|
        fisk.mov(fisk.r8, fisk.imm64(1))
      }
    }

    one, two = 2.times.map { fisk.to_binary }

    assert_equal one, two
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

  def test_push_r8
    fisk.push fisk.r8
    bin = fisk.to_binary
    i = disasm(bin).first
    assert_equal "push", i.mnemonic.to_s
    assert_equal "r8", i.op_str.to_s
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

  def test_comments
    fisk.comment "will xor"
    fisk.comment "second comment"
    fisk.xor fisk.rax, fisk.rax
    fisk.comment "did xor"
    fisk.mov fisk.rax, fisk.rax
    metadata = {}
    binary = fisk.to_binary metadata: metadata
    comments = metadata[:comments]
    insns = disasm(binary)
    assert_equal "will xor\nsecond comment", comments[insns[0].address]
    assert_equal "xor", insns[0].mnemonic.to_s
    assert_equal "did xor", comments[insns[1].address]
    assert_equal "mov", insns[1].mnemonic.to_s
  end
  
  def test_r8h
    fisk.mov fisk.ah, fisk.imm8(1)
    binary = fisk.to_binary
    i = disasm(binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "ah, 1", i.op_str.to_s
  end

  def test_r8l
    fisk.mov fisk.al, fisk.imm8(1)
    binary = fisk.to_binary
    i = disasm(binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "al, 1", i.op_str.to_s
  end

  def test_r8rex
    fisk.mov fisk.spl, fisk.imm8(1)
    binary = fisk.to_binary
    i = disasm(binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "spl, 1", i.op_str.to_s
  end

  def test_r16
    fisk.mov fisk.ax, fisk.imm16(1)
    binary = fisk.to_binary
    i = disasm(binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "ax, 1", i.op_str.to_s
  end

  def test_r32
    fisk.mov fisk.eax, fisk.imm32(1)
    binary = fisk.to_binary
    i = disasm(binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "eax, 1", i.op_str.to_s
  end

  def test_r64
    fisk.mov fisk.rax, fisk.imm32(1)
    binary = fisk.to_binary
    i = disasm(binary).first
    assert_equal "mov", i.mnemonic.to_s
    assert_equal "rax, 1", i.op_str.to_s
  end

  def test_set
    fisk.mov fisk.r9, fisk.imm64(1)
    fisk.mov fisk.r10, fisk.imm64(2)
    fisk.cmp fisk.r9, fisk.r10
    fisk.sete fisk.al
    binary = fisk.to_binary
    i = disasm(binary)[3]
    assert_equal "sete", i.mnemonic.to_s
    assert_equal "al", i.op_str.to_s
  end

  def test_cmov
    fisk.mov fisk.r9, fisk.imm64(1)
    fisk.mov fisk.r10, fisk.imm64(2)
    fisk.cmp fisk.r9, fisk.r10
    fisk.cmove fisk.r9, fisk.r10
    binary = fisk.to_binary
    i = disasm(binary)[3]
    assert_equal "cmove", i.mnemonic.to_s
    assert_equal "r9, r10", i.op_str.to_s
  end
end
