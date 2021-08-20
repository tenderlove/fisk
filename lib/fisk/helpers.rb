require "fiddle"

class Fisk
  module Helpers
    include Fiddle

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

    if RUBY_PLATFORM =~ /darwin/
      MAP_ANON    = 0x1000
    else
      MAP_ANON    = 0x20
    end

    mmap_ptr = Handle::DEFAULT["mmap"]
    mmap_func = Function.new mmap_ptr, [TYPE_VOIDP,
                                        TYPE_SIZE_T,
                                        TYPE_INT,
                                        TYPE_INT,
                                        TYPE_INT,
                                        TYPE_INT], TYPE_VOIDP, name: "mmap"

    memcpy_ptr = Handle::DEFAULT["memcpy"]
    memcpy_func = Function.new memcpy_ptr, [TYPE_VOIDP,
                                            TYPE_VOIDP,
                                            TYPE_SIZE_T], TYPE_VOIDP, name: "memcpy"

    # Expose the mmap system call
    define_singleton_method :mmap, &mmap_func

    # Expose the memcpy system call
    define_singleton_method :memcpy, &memcpy_func

    def self.mmap_jit size
      ptr = mmap 0, size, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANON, -1, 0
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
        @memory[@pos] = byte
        @pos += 1
      end

      def seek pos, whence = IO::SEEK_SET
        raise NotImplementedError if whence != IO::SEEK_SET

        @pos = pos
        self
      end

      def to_function params, ret
        Fiddle::Function.new memory.to_i, params, ret
      end

      # Write a jump instruction at location +at+ that jumps to the location
      # specified by +to+. +type+ specifies the type of jump
      def patch_jump at:, to:, type: :jmp
        saved_pos = self.pos
        rel_jump = 0xCAFE
        2.times do
          seek at, IO::SEEK_SET
          Fisk.new { |__| __.public_send(type, __.rel32(rel_jump)) }.write_to(self)
          rel_jump = to - address
        end
        seek saved_pos, IO::SEEK_SET
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
