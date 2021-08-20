require "helper"
require "fisk/helpers"

class RunFiskTest < Fisk::Test
  def test_jit_jump_patch
    jitbuf = Fisk::Helpers.jitbuffer 4096
    jump_pos = nil
    fisk = Fisk.new { |__|
      __.push(__.rbp)
        .mov(__.rbp, __.rsp)
        .mov(__.rax, __.imm64(-123))

      __.lazy { |pos| jump_pos = pos }
        .jmp(__.rel32(1234))
    }
    fisk.write_to jitbuf
    jump = disasm(jitbuf.memory[0, 4096])[3]

    assert_equal "jmp", jump.mnemonic.to_s
    assert_equal "0x4e5", jump.op_str.to_s

    jitbuf.patch_jump at: jump_pos, to: jitbuf.memory.to_i

    jump = disasm(jitbuf.memory[0, 4096])[3]
    assert_equal "jmp", jump.mnemonic.to_s
    assert_equal "0", jump.op_str.to_s

    jitbuf.patch_jump at: jump_pos, to: jitbuf.memory.to_i + 0xFF

    jump = disasm(jitbuf.memory[0, 4096])[3]
    assert_equal "jmp", jump.mnemonic.to_s
    assert_equal "0xff", jump.op_str.to_s
  end

  def test_jit_patch_jump_type
    jitbuf = Fisk::Helpers.jitbuffer 4096
    jump_pos = nil
    fisk = Fisk.new { |__|
      __.push(__.rbp)
        .mov(__.rbp, __.rsp)
        .mov(__.rax, __.imm64(-123))

      __.lazy { |pos| jump_pos = pos }
        .jmp(__.rel32(1234))
    }
    fisk.write_to jitbuf
    jump = disasm(jitbuf.memory[0, 4096])[3]

    assert_equal "jmp", jump.mnemonic.to_s
    assert_equal "0x4e5", jump.op_str.to_s

    jitbuf.patch_jump at: jump_pos, to: jitbuf.memory.to_i, type: :jg

    jump = disasm(jitbuf.memory[0, 4096])[3]
    assert_equal "jg", jump.mnemonic.to_s
    assert_equal "0", jump.op_str.to_s

    jitbuf.patch_jump at: jump_pos, to: jitbuf.memory.to_i + 0xFF, type: :jne

    jump = disasm(jitbuf.memory[0, 4096])[3]
    assert_equal "jne", jump.mnemonic.to_s
    assert_equal "0xff", jump.op_str.to_s
  end

  def test_jit_patch_maintains_position
    jitbuf = Fisk::Helpers.jitbuffer 4096
    jump_pos = nil
    fisk = Fisk.new { |__|
      __.push(__.rbp)
        .mov(__.rbp, __.rsp)
        .mov(__.rax, __.imm64(-123))

      __.lazy { |pos| jump_pos = pos }
        .jmp(__.rel32(1234))
    }
    fisk.write_to jitbuf
    jump = disasm(jitbuf.memory[0, 4096])[3]

    assert_equal "jmp", jump.mnemonic.to_s
    assert_equal "0x4e5", jump.op_str.to_s

    pos = jitbuf.pos
    jitbuf.patch_jump at: jump_pos, to: jitbuf.memory.to_i, type: :jg
    assert_equal pos, jitbuf.pos
  end

  def test_write_jump_moves
    jitbuf = Fisk::Helpers.jitbuffer 4096
    jump_pos = nil
    fisk = Fisk.new { |__|
      __.push(__.rbp)
        .mov(__.rbp, __.rsp)
        .mov(__.rax, __.imm64(-123))
    }
    fisk.write_to jitbuf

    current_pos = jitbuf.pos
    assert_equal current_pos, jitbuf.write_jump(to: jitbuf.address + 0xFF)

    jump = disasm(jitbuf.memory[current_pos, jitbuf.pos])[0]

    assert_equal "jmp", jump.mnemonic.to_s
    assert_equal "0xff", jump.op_str.to_s
  end

  def test_negative
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rax, imm64(-123)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal(-123, func.call)
  end

  def test_forward_label_rel32
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    str = " " * 0xFFFFF
    ptr = Fiddle::Pointer[str]

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rdx, imm32(1)
      jmp label(:foo)
      mov r8, imm64(ptr.to_i)
      mov r8, m64(r8, 0xFFFF)
      int lit(3) # crash if we don't jump over this
    put_label :foo
      mov rax, imm32(0x3)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 3, func.call
  end

  def test_label_rel32
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    str = " " * 0xFFFFF
    ptr = Fiddle::Pointer[str]

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rdx, imm32(1)
      mov r8, imm64(ptr.to_i)
      mov r8, m64(r8, 0xFFFF)
      xor rax, rax
    put_label :loop
      add rax, rdx
      500.times { nop }
      inc rdx
      cmp rdx, imm32(10)
      jbe label(:loop)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 11.times.inject(:+), func.call
  end

  def test_label_rel8
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    str = " " * 0xFFFFF
    ptr = Fiddle::Pointer[str]

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rdx, imm32(1)
      mov r8, imm64(ptr.to_i)
      mov r8, m64(r8, 0xFFFF)
      xor rax, rax
    put_label :loop
      add rax, rdx
      inc rdx
      cmp rdx, imm32(10)
      jbe label(:loop)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 11.times.inject(:+), func.call
  end

  def test_sum
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rdx, imm32(1)
      xor rax, rax
    put_label :loop
      add rax, rdx
      inc rdx
      cmp rdx, imm32(10)
      jbe label(:loop)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 11.times.inject(:+), func.call
  end

  def test_jmp
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      jmp label(:foo)
      put_label(:bar)
      mov rax, imm32(100)
      pop rbp
      ret
      put_label(:foo)
      jmp label(:bar)
      mov rax, imm32(42)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 100, func.call
  end

  def test_run_fisk
    fisk = Fisk.new
    mem = Fisk::Helpers.mmap_jit 4096

    binary = fisk.asm do
      push rbp
      mov rbp, rsp
      mov rax, imm32(100)
      pop rbp
      ret
    end

    Fisk::Helpers.memcpy mem, binary.string, binary.string.bytesize
    func = Fiddle::Function.new mem.to_i, [], Fiddle::TYPE_INT
    assert_equal 100, func.call
  end

  def test_jit_memory_has_size
    mem = Fisk::Helpers.mmap_jit 100
    assert_equal 100, mem.size
  end

  def test_get_address
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rax, rdi
      pop rbp
      ret
    end

    func = jitbuf.to_function [Fiddle::TYPE_VOIDP], Fiddle::TYPE_LONG
    x = Object.new
    wrapped = Fiddle.dlwrap x
    assert_equal wrapped.to_i, func.call(wrapped)
  end

  def test_fisk_jit
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rax, imm32(100)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 100, func.call
  end

  def test_fisk_get_param
    fisk = Fisk.new
    jitbuf = Fisk::Helpers.jitbuffer 4096

    fisk.asm jitbuf do
      push rbp
      mov rbp, rsp
      mov rax, imm32(100)
      pop rbp
      ret
    end

    func = jitbuf.to_function [], Fiddle::TYPE_INT
    assert_equal 100, func.call
  end
end
