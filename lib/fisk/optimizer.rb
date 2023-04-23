class Fisk
  class Optimizer
    def optimize(insn)
      case insn.insn.name
      when Instructions::MOV.name
        if insn.operands[0].register? && insn.operands[1].register? && insn.operands[0].name == insn.operands[1].name
          return nil
        end
      end

      return insn
    end
  end
end
