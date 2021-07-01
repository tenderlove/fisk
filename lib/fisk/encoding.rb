class Fisk
  class Encoding
    private

    def add_modrm buffer, operands, mode, reg, rm
      offset_bytes = 0
      if mem = operands.find(&:m64?)
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
