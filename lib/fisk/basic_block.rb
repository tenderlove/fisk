class Fisk
  class CFG < Struct.new(:variables, :blocks)
    class BasicBlock < Struct.new(:name, :insns, :fall, :jump, :def, :use, :in, :out, :pred, :start_point, :end_point)
      def jump?
        insns.last.jump?
      end

      def jump_name
        insns.last.target
      end

      def succ
        list = []
        list << fall if fall
        list << jump if jump
        list
      end

      def live; self.def | self.use | self.out; end
    end

    def self.build instructions
      blocks = []
      bb_index = 0

      chunks = instructions.chunk { |insn|
        if insn.label?
          # start a new block here
          bb_index += 1
        end

        ret_idx = bb_index

        if insn.jump?
          # end the block here
          bb_index += 1
        end

        ret_idx
      }.to_a

      chunk_name = ->(chunk_id, insns) {
        if insns.first.label?
          insns.first.name
        else
          :"bb_#{chunk_id}"
        end
      }

      jump_targets = {}
      wants_target = []
      insn_idx = 0

      chunks.each_with_index do |(chunk_id, insns), idx|
        prev_block = blocks.last

        name = chunk_name.(chunk_id, insns)

        next_chunk_id, next_insns = chunks[idx + 1]

        outgoing = []

        if next_chunk_id
          outgoing << chunk_name.(next_chunk_id, next_insns)
        end

        bb = BasicBlock.new(name, insns)
        bb.pred = []
        bb.start_point = insn_idx
        insn_idx += insns.length
        bb.end_point = insn_idx - 1

        if bb.jump?
          target_name = bb.jump_name

          # if we need to jump backwards, the label should already be filled in.
          # Otherwise we need to find the block later (we're jumping forward)
          if jump_targets[target_name]
            jt = jump_targets[target_name]
            bb.jump = jt
            jt.pred << bb
          else
            wants_target << bb
          end
        end

        jump_targets[bb.name] = bb

        if prev_block
          prev_block.fall = bb
          bb.pred << prev_block
        end

        blocks << bb
      end

      # fill in any forward jumps
      wants_target.each { |bb|
        jt = jump_targets[bb.jump_name]
        bb.jump = jt
        jt.pred << bb
      }

      variables = live_variables blocks

      CFG.new variables, blocks
    end

    def self.live_variables blocks
      seen = Set.new

      blocks.each do |block|
        used = Set.new
        defd = Set.new

        block.insns.each do |insn|
          if insn.has_temp_registers?
            insn.temp_registers.each do |reg|
              defd << reg unless seen.include?(reg)
              used << reg unless defd.include?(reg)
              seen << reg
            end
          end
        end

        block.use = used.to_a
        block.def = defd.to_a
        block.in  = []
        block.out = []
      end

      worklist = blocks.dup
      while block = worklist.pop
        block.out = block.succ.inject([]) { |out_registers, succ_block|
          out_registers | succ_block.in
        }
        ins = block.in | block.use | (block.out - block.def)

        if ins == block.in
          # Done with this block!
          block.live.each do |live_register|
            live_register.end_point ||= block.end_point

            if live_register.start_point > block.start_point
              live_register.start_point = block.start_point
            end

            if live_register.end_point < block.end_point
              live_register.end_point = block.end_point
            end
          end
        else
          block.in = ins
          worklist.concat(block.pred)
        end
      end

      seen
    end
  end

end
