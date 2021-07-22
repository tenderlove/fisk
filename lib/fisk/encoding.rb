class Fisk
  class Encoding
    private

    def add_modrm buffer, mode, reg, rm, operands
      offset_bytes = 0
      if mem = operands.find(&:memory?)
        if mem.displacement != 0
          if 0xFF == mem.displacement | 0xFF
            offset_bytes = 1
            mode |= 0x1
          else
            offset_bytes = 4
            mode |= 0x2
          end
        end
      end
      reg = reg & 0x7
      rm = rm & 0x7
      buffer.putc ((mode << 6) | (reg << 3) | rm)
      if mem && mem.displacement != 0
        write_num buffer, mem.displacement, offset_bytes
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
      offset_bytes = 0

      if mem.rip?
        buffer.putc 0x5
        write_num buffer, mem.displacement, 4
        return
      end

      if mem.displacement != 0
        if 0xFF == mem.displacement | 0xFF
          offset_bytes = 1
          mode |= 0x1
        else
          offset_bytes = 4
          mode |= 0x2
        end
      end

      reg = reg & 0x7
      rm = rm & 0x7
      buffer.putc ((mode << 6) | (reg << 3) | rm)

      if mem.displacement != 0
        write_num buffer, mem.displacement, offset_bytes
      end
    end

    # Add ModRM with two register operands
    def add_modrm_reg_reg buffer, mode, reg, rm, operands
      if rip = operands.find(&:rip?)
        buffer.putc 0x5
        write_num buffer, rip.displacement, 4
      else
        reg = reg & 0x7
        rm = rm & 0x7
        buffer.putc ((mode << 6) | (reg << 3) | rm)
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
      return if mandatory == false && !operands.any?(&:extended_register?)

      rex = 0b0100
      rex = (rex << 1) | w
      rex = (rex << 1) | r
      rex = (rex << 1) | x
      rex = (rex << 1) | b
      buffer.putc rex
    end

    def add_opcode buffer, byte, addend
      byte |= addend
      buffer.putc byte
    end

    def write_num buffer, num, size
      size.times {
        buffer.putc(num & 0xFF)
        num >>= 8
      }
    end
  end
end
