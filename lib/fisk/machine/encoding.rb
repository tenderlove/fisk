class Fisk
  class Machine
    class Encoding
      private

      def add_modrm buffer, operands, mode, reg, rm
        offset_bytes = 0
        if mem = operands.find(&:m64?)
          if mem.displacement > 0
            if mem.displacement <= 0xFF
              offset_bytes = 1
              mode |= 0x1
            else
              offset_bytes = 4
              mode |= 0x2
            end
          end
        end
        reg = get_operand_value(reg, operands) & 0x7
        rm = get_operand_value(rm, operands) & 0x7
        buffer.putc ((mode << 6) | (reg << 3) | rm)
        if mem && mem.displacement > 0
          write_num buffer, mem.displacement, offset_bytes
        end
      end

      def add_immediate buffer, operands, value, size
        value = get_operand_value(value, operands)
        write_num buffer, value, size
      end

      def add_code_offset buffer, operands, value, size
        value = get_operand_value(value, operands)
        write_num buffer, value, size
      end

      def add_data_offset buffer, operands, value, size
        value = get_operand_value(value, operands)
        write_num buffer, value, size
      end

      def add_rex buffer, operands, mandatory, w, r, x, b
        return if mandatory == false && !operands.any?(&:extended_register?)

        rex = 0b0100
        rex = (rex << 1) | check_rex(w, operands)
        rex = (rex << 1) | check_rex(r, operands)
        rex = (rex << 1) | check_rex(x, operands)
        rex = (rex << 1) | check_rex(b, operands)
        buffer.putc rex
      end

      def add_opcode buffer, operands, byte, addend
        if addend
          byte |= get_operand_value(addend, operands)
        end

        buffer.putc byte
      end

      def get_operand_value v, operands
        case v
        when /^#(\d+)$/
          operands[$1.to_i].value
        when /^(\d+)$/
          $1.to_i
        else
          raise NotImplementedError
        end
      end

      def check_rex v, operands
        return 0 unless v

        case v
        when /^(\d+)$/
          v.to_i
        when /^#(\d+)$/
          (operands[$1.to_i].value >> 3)
        else
          raise NotImplementedError, v
        end
      end

      def write_num buffer, num, size
        size.times {
          buffer.putc(num & 0xFF)
          num >>= 8
        }
      end
    end
  end
end
