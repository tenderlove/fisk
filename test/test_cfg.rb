require "helper"

class Fisk
  class CFGTest < Fisk::Test
    attr_reader :fisk

    def setup
      super
      @fisk = Fisk.new
    end

    def test_no_jumps
      fisk.push fisk.r8
      basic_blocks = fisk.basic_blocks
      assert_equal 1, basic_blocks.length

      block = basic_blocks.first
      assert_nil block.jump
      assert_nil block.fall
    end

    def test_simple_jump
      fisk.push fisk.r8
      fisk.jmp fisk.label(:foo)
      fisk.put_label(:foo)
      fisk.nop

      basic_blocks = fisk.basic_blocks
      assert_equal 2, basic_blocks.length

      block = basic_blocks.first
      assert_equal :foo, block.jump.name
      assert_equal :foo, block.fall.name

      block2 = basic_blocks.last
      assert_nil block2.jump
      assert_nil block2.fall
    end

    def test_jump_and_fall
      fisk.push fisk.r8
      fisk.jmp fisk.label(:foo)
      fisk.nop
      fisk.nop
      fisk.nop
      fisk.put_label(:foo)
      fisk.nop

      blocks = fisk.basic_blocks
      assert_equal 3, blocks.length

      assert_predicate blocks[0], :jump?

      assert_equal :foo, blocks[0].jump.name
      assert_equal blocks[2], blocks[0].jump
      assert_equal :foo, blocks[2].name

      assert blocks[0].jump
      assert blocks[0].fall
      assert blocks[1].fall
      refute blocks[1].jump
      refute blocks[2].fall
      refute blocks[2].jump
    end

    def test_jump_backwards
      fisk.push fisk.r8
      fisk.put_label(:foo)
      fisk.nop
      fisk.put_label(:bar)
      fisk.nop
      fisk.jmp fisk.label(:foo)
      fisk.nop
      fisk.nop

      blocks = fisk.basic_blocks
      assert_equal 4, blocks.length

      refute_predicate blocks[0], :jump?
      refute_predicate blocks[1], :jump?
      assert_predicate blocks[2], :jump?
      assert_equal blocks[1], blocks[2].jump
    end

    def test_jump_self
      fisk.put_label(:foo)
      fisk.nop
      fisk.nop
      fisk.jmp fisk.label(:foo)
      fisk.nop
      fisk.nop

      blocks = fisk.basic_blocks
      assert_equal 2, blocks.length

      assert_predicate blocks[0], :jump?
      refute_predicate blocks[1], :jump?
      assert_equal blocks[0], blocks[0].jump
      assert_equal blocks[1], blocks[0].fall
    end

    def test_loop
      __ = fisk
      reg1 = fisk.r9
      reg2 = fisk.r10
      reg3 = fisk.rax

      __.mov(reg1, __.imm32(1))    # block 0
        .mov(reg2, __.imm32(1))
        .put_label(:head)          # block 1
        .cmp(reg1, __.imm32(100))
        .ja(__.label(:break))
        .add(reg1, reg2)           # block 2
        .mov(reg3, __.imm32(1))
        .mov(reg2, reg3)
        .jmp(__.label(:head))
        .put_label(:break)         # block 3

      blocks = fisk.basic_blocks
      assert_equal 4, blocks.length

      refute_predicate blocks[0], :jump?
      assert_predicate blocks[1], :jump?
      assert_equal blocks.last, blocks[1].jump
      assert_equal blocks[2], blocks[1].fall
      assert_predicate blocks[2], :jump?
      assert_equal blocks[1], blocks[2].jump
    end

    def test_use_def
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

      blocks = fisk.basic_blocks

      assert_equal [reg1, reg2], blocks[0].def
      assert_equal [], blocks[0].use

      assert_equal [], blocks[1].def
      assert_equal [reg1], blocks[1].use

      assert_equal [reg3], blocks[2].def
      assert_equal [reg1, reg2], blocks[2].use

      assert_equal [], blocks[3].def
      assert_equal [], blocks[3].use
    end

    def test_pred
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

      blocks = fisk.basic_blocks

      assert_equal [blocks[1], blocks[2]].map(&:name).sort, blocks[3].pred.map(&:name).sort
      assert_equal [blocks[1]].map(&:name).sort, blocks[2].pred.map(&:name).sort
      assert_equal [blocks[0], blocks[2]].map(&:name).sort, blocks[1].pred.map(&:name).sort
      assert_equal [], blocks[0].pred
    end

    def test_live
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

      blocks = fisk.basic_blocks


      assert_equal [reg1, reg2].map(&:name).sort,       blocks[0].live.map(&:name).sort
      assert_equal [reg1, reg2].map(&:name).sort,       blocks[1].live.map(&:name).sort
      assert_equal [reg1, reg2, reg3].map(&:name).sort, blocks[2].live.map(&:name).sort
      assert_equal [],                                  blocks[3].live
    end

    def test_register_range
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

      fisk.basic_blocks

      assert_equal 0, reg1.start_point
      assert_equal 0, reg2.start_point
      assert_equal 5, reg3.start_point

      assert_equal 8, reg1.end_point
      assert_equal 8, reg2.end_point
      assert_equal 8, reg3.end_point
    end
  end
end
