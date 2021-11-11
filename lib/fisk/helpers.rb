require "fiddle"

class Fisk
  module Helpers
    include Fiddle
    extend Fiddle

    class Fiddle::Function
      def to_proc
        this = self
        lambda { |*args| this.call(*args) }
      end
    end unless Function.method_defined?(:to_proc)

    # from sys/mman.h on macOS
    PROT_READ   = 0x01
    PROT_WRITE  = 0x02
    PROT_EXEC   = 0x04
    MAP_PRIVATE = 0x0002

    if RUBY_PLATFORM =~ /darwin|openbsd/i
      MAP_ANON    = 0x1000
    else
      MAP_ANON    = 0x20
    end

    class << self
      mmap_ptr = Handle::DEFAULT["mmap"]
      mmap_func = Function.new mmap_ptr, [TYPE_VOIDP,
                                          TYPE_SIZE_T,
                                          TYPE_INT,
                                          TYPE_INT,
                                          TYPE_INT,
                                          TYPE_INT], TYPE_VOIDP, name: "mmap"

      mprotect_ptr = Handle::DEFAULT["mprotect"]
      mprotect_func = Function.new mprotect_ptr, [TYPE_VOIDP,
                                                  TYPE_SIZE_T,
                                                  TYPE_INT], TYPE_INT, name: "mprotect"

      memcpy_ptr = Handle::DEFAULT["memcpy"]
      memcpy_func = Function.new memcpy_ptr, [TYPE_VOIDP,
                                              TYPE_VOIDP,
                                              TYPE_SIZE_T], TYPE_VOIDP, name: "memcpy"

      def mmap(*args)
        ptr = _mmap(*args)
        if ptr.to_i == -1
          raise RuntimeError, "mmap failed"
        end
        ptr
      end

      def mprotect(*args)
        ret = _mprotect(*args)
        if ret == -1
          raise RuntimeError, "mprotect failed"
        end
        ret 
      end

      # Expose the memcpy system call
      define_method :memcpy, &memcpy_func

      private

      # Expose the mmap system call
      define_method :_mmap, &mmap_func

      # Expose the mmap system call
      define_method :_mprotect, &mprotect_func
    end

    def self.mmap_jit size
      ptr = mmap 0, size, PROT_READ | PROT_EXEC, MAP_PRIVATE | MAP_ANON, -1, 0
      ptr.size = size
      ptr
    end

    class JITBuffer
      attr_reader :memory, :pos

      def initialize memory, size
        @memory = memory
        @pos = 0
        @size = size
      end

      def putc byte
        raise "Buffer full! #{pos} - #{@size}" if pos >= @size
        @memory[@pos] = byte
        @pos += 1
      end

      def seek pos, whence = IO::SEEK_SET
        raise NotImplementedError if whence != IO::SEEK_SET
        raise if pos >= @size

        @pos = pos
        self
      end

      def to_function params, ret
        Fiddle::Function.new memory.to_i, params, ret
      end

      # Write a jump instruction at location +at+ that jumps to the location
      # specified by +to+. +type+ specifies the type of jump.  This method
      # maintains the current position of the cursor inside the memory chunk
      def patch_jump at:, to:, type: :jmp
        pos = self.pos
        write_jump(to: to, at: at, type: type)
        seek pos, IO::SEEK_SET
      end

      # Write a jump instruction at location +at+ that jumps to the location
      # specified by +to+. +type+ specifies the type of jump.  Returns the
      # position in the buffer where the jump instruction was written.
      #
      # This method does not maintain the current position of the cursor
      def write_jump to:, at: self.pos, type: :jmp
        rel_jump = 0xCAFE
        2.times do
          seek at, IO::SEEK_SET
          Fisk.new { |__| __.public_send(type, __.rel32(rel_jump)) }.write_to(self)
          rel_jump = to - address
        end
        self.pos
      end

      def allow_writes
        Fisk::Helpers.mprotect(memory, @size, PROT_READ | PROT_WRITE)
        yield
      ensure
        Fisk::Helpers.mprotect(memory, @size, PROT_READ | PROT_EXEC)
      end

      def address
        memory.to_i + pos
      end
    end

    def self.jitbuffer size
      JITBuffer.new mmap_jit(size), size
    end
  end
end
