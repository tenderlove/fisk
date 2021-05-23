require "fisk"
require "fisk/helpers"

module Printer
  fisk = Fisk.new

  jitbuf = Fisk::Helpers.jitbuffer 4096

  str = "fooooooooo\n"
  wrapper = Fiddle::Pointer[str]

  fisk.asm(jitbuf) do
    push rbp
    mov rdi, imm32(1)            # File number for stdout
    mov rsi, imm64(wrapper.to_i) # Address of the char * backing str
    mov rdx, imm32(str.bytesize) # Number of bytes in the string
    mov rax, imm32(0x02000004)   # write syscall on macOS x86_64
    syscall
    pop rbp
    ret
  end

  define_singleton_method :print!, &jitbuf.to_function([], Fiddle::TYPE_VOID)
end

Printer.print!
