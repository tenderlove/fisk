require "helper"

class RegisterAllocationTest < Fisk::Test
  attr_reader :fisk

  def setup
    super
    @fisk = Fisk.new
  end

  def test_with_memory_operand
    reg = fisk.register
    fisk.m64(reg)
    fisk.assign_registers([fisk.r9])
  end

  def test_with_unresolved_jumps
    reg = fisk.register
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
    fisk.xor reg2, reg2
    fisk.assign_registers([Fisk::Registers::R9])
    i = disasm(fisk.to_binary)
    assert_equal "xor", i[0].mnemonic.to_s
    assert_equal "r9, r9", i[0].op_str.to_s
    assert_equal "xor", i[1].mnemonic.to_s
    assert_equal "r9, r9", i[1].op_str.to_s
  end

  def test_spill_not_implemented
    reg1 = fisk.register
    reg2 = fisk.register
    fisk.xor reg1, reg2

    assert_raises(NotImplementedError) do
      fisk.assign_registers([Fisk::Registers::R9])
    end
  end
end
