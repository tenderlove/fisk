class Fisk
  class Encoding
    private

    def add_modrm buffer, mode, reg, rm, operands
      if mem = operands.find(&:memory?)
        add_modrm_mem mem, buffer, mode, reg, rm
      else
        buffer.putc ((mode << 6) | ((reg & 0x7) << 3) | (rm & 0x7))
        1
      end
    end

    def add_modrm_mem mem, buffer, mode, reg, rm
      offset_bytes = 0
      if mem.displacement != 0 || (rm & 0x7) == 5 # RBP / r13 needs an offset
        if mem.displacement >= -0x7F - 1 && mem.displacement < 0x7F
          offset_bytes = 1
          mode |= 0x1
        else
          offset_bytes = 4
          mode |= 0x2
        end
      end

      count = 1

      modrm_byte = ((mode << 6) | ((reg & 0x7) << 3) | (rm & 0x7))
      buffer.putc modrm_byte

      # Needs SIB, Table 2-2
      if rm & 0x7 == 4 # RSP register / r12
        count += 1
        buffer.putc 0x24
      end

      if mem && (mem.displacement != 0 || (rm & 0x7) == 5)
        count + write_num(buffer, mem.displacement, offset_bytes)
      else
        count
      end
    end


    # Add ModRM with one mem operand and one register operand
    def add_modrm_mem_reg buffer, mode, reg, rm, operands
      add_modrm_mem_reg_ buffer, mode, reg, rm, operands[0], operands[1]
    end

    # Add ModRM with one mem operand and one register operand
    def add_modrm_reg_mem buffer, mode, reg, rm, operands
      add_modrm_mem_reg_ buffer, mode, reg, rm, operands[1], operands[0]
    end

    def add_modrm_mem_reg_ buffer, mode, reg, rm, mem, reg_opnd
      if mem.rip?
        buffer.putc 0x5 + ((reg_opnd.value % 8) * 8)
        return 1 + write_num(buffer, mem.displacement, 4)
      end

      add_modrm_mem mem, buffer, mode, reg, rm
    end

    # Add ModRM with two register operands
    def add_modrm_reg_reg buffer, mode, reg, rm, operands
      if rip = operands.find(&:rip?)
        buffer.putc 0x5
        1 + write_num(buffer, rip.displacement, 4)
      else
        reg = reg & 0x7
        rm = rm & 0x7
        buffer.putc ((mode << 6) | (reg << 3) | rm)
        1
      end
    end

    def add_immediate buffer, value, size
      write_num buffer, value, size
    end

    def add_code_offset buffer, value, size
      write_num buffer, value, size
    end

    def add_data_offset buffer, value, size
      write_num buffer, value, size
    end

    def add_rex buffer, operands, mandatory, w, r, x, b
      return 0 if mandatory == false && !operands.any?(&:extended_register?)

      if mem = operands.find(&:memory?)
        if mem.extended_register?
          x = 0
          b = 1
        end
      end

      rex = 0b0100
      rex = (rex << 1) | w
      rex = (rex << 1) | r
      rex = (rex << 1) | x
      rex = (rex << 1) | b
      buffer.putc rex
      1
    end

    def add_opcode buffer, byte, addend
      byte |= (addend & 0x7)
      buffer.putc byte
      1
    end

    def write_num buffer, num, size
      size.times {
        buffer.putc(num & 0xFF)
        num >>= 8
      }
      size
    end

    def add_prefix buffer, operands, byte, mandatory
      buffer.putc byte
      1
    end
  end
end
