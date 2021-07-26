require "helper"

class RegisterAllocationTest < Fisk::Test
  attr_reader :fisk

  def setup
    super
    @fisk = Fisk.new
  end

  def test_encode_temp_register_without_assignemt_raises
    reg = fisk.register
    fisk.push(reg)

    assert_raises Fisk::Errors::UnassignedRegister do
      fisk.to_binary
    end
  end

  def test_push_r8_with_reg_assignment
    reg = fisk.register
    fisk.push(reg)
    fisk.assign_registers([fisk.r8, fisk.r9])

    i = disasm(fisk.to_binary).first
    assert_equal "push", i.mnemonic.to_s
    assert_equal "r8", i.op_str.to_s
  end

  def test_call_r8_with_reg_assignment
    reg = fisk.register
    fisk.mov(reg, fisk.imm64(123))
    fisk.call(reg)
    fisk.assign_registers([fisk.r8, fisk.r9])

    i = disasm(fisk.to_binary)[1]
    assert_equal "call", i.mnemonic.to_s
    assert_equal "r8", i.op_str.to_s
  end

  def test_with_memory_operand
    reg = fisk.register
    fisk.m64(reg)
    fisk.assign_registers([fisk.r9])
  end

  def test_with_unresolved_jumps
    label = fisk.label "foo"
    fisk.jmp label
    fisk.put_label "foo"
    fisk.assign_registers([fisk.r9])
  end

  def test_make_temporary_register_with_name
    name = "aaron"
    reg = fisk.register name

    assert reg
    assert_equal "r64", reg.type
    assert_equal name, reg.name
  end

  def test_make_temporary_register
    reg = fisk.register

    assert reg
    assert_equal "r64", reg.type
    assert_equal "temp", reg.name
  end

  def test_two_registers_are_not_same
    reg1 = fisk.register
    reg2 = fisk.register

    refute_same reg1, reg2
  end

  def test_assign_registers
    reg = fisk.register
    fisk.mov reg, fisk.imm64(2)
    fisk.assign_registers([Fisk::Registers::R9])
    i = disasm(fisk.to_binary).first
    assert_equal "movabs", i.mnemonic.to_s
    assert_equal "r9, 2", i.op_str.to_s
  end

  def test_assign_same_registers
    reg = fisk.register
    fisk.mov reg, fisk.imm64(2)
    fisk.mov fisk.rax, reg
    fisk.assign_registers([Fisk::Registers::R9])
    i = disasm(fisk.to_binary)
    assert_equal "movabs", i[0].mnemonic.to_s
    assert_equal "r9, 2", i[0].op_str.to_s
    assert_equal "mov", i[1].mnemonic.to_s
    assert_equal "rax, r9", i[1].op_str.to_s
  end

  def test_assign_same_location
    reg = fisk.register
    fisk.xor reg, reg
    fisk.assign_registers([Fisk::Registers::R9])
    i = disasm(fisk.to_binary)
    assert_equal "xor", i[0].mnemonic.to_s
    assert_equal "r9, r9", i[0].op_str.to_s
  end

  def test_assign_two_registers
    reg1 = fisk.register
    reg2 = fisk.register
    fisk.xor reg1, reg2
    fisk.assign_registers([Fisk::Registers::R9, Fisk::Registers::R10])
    i = disasm(fisk.to_binary)
    assert_equal "xor", i[0].mnemonic.to_s
    assert_equal ["r9", "r10"].sort, i[0].op_str.to_s.split(", ").sort
  end

  def test_reuse_register
    reg1 = fisk.register
    reg2 = fisk.register
    fisk.xor reg1, reg1
    fisk.put_label(:foo) # make two basic blocks
    fisk.xor reg2, reg2
    fisk.assign_registers([Fisk::Registers::R9])
    i = disasm(fisk.to_binary)
    assert_equal "xor", i[0].mnemonic.to_s
    assert_equal "r9, r9", i[0].op_str.to_s
    assert_equal "xor", i[1].mnemonic.to_s
    assert_equal "r9, r9", i[1].op_str.to_s
  end

  def test_spill_not_implemented_cfg
    __ = fisk

    reg1 = fisk.register("temp1")
    reg2 = fisk.register("temp2")
    reg3 = fisk.register("temp3")

    __.mov(reg1, fisk.imm32(1))    # block 0
      .mov(reg2, fisk.imm32(1))
    .put_label(:head)              # block 1
      .cmp(reg1, fisk.imm32(100))
      .jg(fisk.label(:break))
      .add(reg1, reg2)             # block 2
      .mov(reg3, fisk.imm32(1))
      .mov(reg2, reg3)
      .jmp(fisk.label(:head))
    .put_label(:break)             # block 3

    assert_raises(NotImplementedError) do
      fisk.assign_registers([Fisk::Registers::R8, Fisk::Registers::R9])
    end

    fisk.assign_registers([Fisk::Registers::R8, Fisk::Registers::R9, Fisk::Registers::R10])

    assert_equal "r8", reg1.register.name
    assert_equal "r9", reg2.register.name
    assert_equal "r10", reg3.register.name
  end

  def test_spill_not_implemented
    reg1 = fisk.register
    reg2 = fisk.register
    fisk.xor reg1, reg2

    assert_raises(NotImplementedError) do
      fisk.assign_registers([Fisk::Registers::R9])
    end
  end

  def test_registers_can_be_released
    reg1 = fisk.register
    reg2 = fisk.register
    fisk.xor reg1, reg1
    fisk.release_register reg1
    fisk.xor reg2, reg2
    fisk.release_register reg2
    fisk.assign_registers([Fisk::Registers::R9], local: true)
    i = disasm(fisk.to_binary)
    assert_equal "xor", i[0].mnemonic.to_s
    assert_equal "r9, r9", i[0].op_str.to_s
    assert_equal "xor", i[1].mnemonic.to_s
    assert_equal "r9, r9", i[1].op_str.to_s
  end

  def test_multiple_releases_is_an_error
    reg1 = fisk.register
    fisk.xor reg1, reg1
    fisk.release_register reg1
    assert_raises Fisk::Errors::AlreadyReleasedError do
      fisk.release_register reg1
    end
  end

  def test_use_after_invalidation_is_error
    reg1 = fisk.register
    fisk.xor reg1, reg1
    fisk.release_register reg1
    assert_raises Fisk::Errors::UseAfterInvalidationError do
      fisk.xor reg1, reg1
    end
  end

  def test_release_all_registers
    reg1 = fisk.register
    fisk.xor reg1, reg1
    fisk.release_all_registers
    assert_raises Fisk::Errors::UseAfterInvalidationError do
      fisk.xor reg1, reg1
    end
  end

  def test_unreleased_registers_raise_exception
    reg1 = fisk.register
    fisk.xor reg1, reg1
    assert_raises Fisk::Errors::UnreleasedRegisterError do
      fisk.assign_registers([Fisk::Registers::R9], local: true)
    end
  end
end
