# Fisk - A Pure Ruby Assembler

This is a pure Ruby x86-64 assembler (I guess).  I'm not 100% sure if it counts
as pure Ruby because it just reads an XML file and metaprograms most of it.
Anyway, you can use it to write assembly in Ruby, then have it assembled.

I named it after Wilson Fisk mainly because it reminds me of [this
project](https://github.com/seattlerb/wilson) and because I've been playing
lots of Spider-Man.

## Usage

Here is an example of assembling something:

```ruby
fisk = Fisk.new

binary = fisk.asm do
  push rbp
  mov rbp, rsp
  int lit(3)
  pop rbp
  ret
end
```

Though, it's not very fun to assemble something unless you can execute it.  So
here is an example of how to execute the above assembly.  This assembly code
will send an interrupt and tell the debugger to stop.  So let's write the
machine code to some executable memory, and call it from a Ruby program that we
will start in lldb.

```ruby
require "fisk"
require "fisk/helpers"

module Break
  fisk = Fisk.new

  jitbuf = Fisk::Helpers.jitbuffer 4096

  fisk.asm(jitbuf) do
    push rbp
    mov rbp, rsp
    int lit(3)
    pop rbp
    ret
  end

  define_singleton_method :dance!, &jitbuf.to_function([], Fiddle::TYPE_VOID)
end

def deep i = 2
  if i == 0
    Break.dance!
  else
    deep(i - 1)
  end
end

deep
```

If we launch this script under lldb, the debugger will halt the process when we call the `dance!` method:

```
[aaron@tc-lan-adapter ~/g/fisk (master)]$ lldb ~/git/ruby/ruby -- -I lib fun.rb
error: module importing failed: invalid pathname
(lldb) target create "/Users/aaron/git/ruby/ruby"
procCurrent executable set to '/Users/aaron/git/ruby/ruby' (x86_64).
(lldb) settings set -- target.run-args  "-I" "lib" "fun.rb"
(lldb) process launch
Process 33042 launched: '/Users/aaron/git/ruby/ruby' (x86_64)
Process 33042 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BREAKPOINT (code=EXC_I386_BPT, subcode=0x0)
    frame #0: 0x00000001007f4005
->  0x1007f4005: popq   %rbp
    0x1007f4006: retq   
    0x1007f4007: addb   %al, (%rax)
    0x1007f4009: addb   %al, (%rax)
Target 0: (ruby) stopped.
(lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BREAKPOINT (code=EXC_I386_BPT, subcode=0x0)
  * frame #0: 0x00000001007f4005
    frame #1: 0x00007fff2db538e5 libffi.dylib`ffi_call_unix64 + 85
    frame #2: 0x00007fff2db5322a libffi.dylib`ffi_call_int + 692
    frame #3: 0x0000000107458e3d fiddle.bundle`nogvl_ffi_call(ptr=0x00007ffeefbf9bb0) at function.c:204:5
    frame #4: 0x00000001002e704f ruby`rb_nogvl(func=(fiddle.bundle`nogvl_ffi_call at function.c:201), data1=0x00007ffeefbf9bb0, ubf=0x0000000000000000, data2=0x0000000000000000, flags=0) at thread.c:1671:5
    frame #5: 0x00000001002e7570 ruby`rb_thread_call_without_gvl(func=(fiddle.bundle`nogvl_ffi_call at function.c:201), data1=0x00007ffeefbf9bb0, ubf=0x0000000000000000, data2=0x0000000000000000) at thread.c:1787:12
    frame #6: 0x00000001074585a6 fiddle.bundle`function_call(argc=0, argv=0x00000001080280c8, self=0x0000000128f85fd8) at function.c:375:15
    frame #7: 0x0000000100383ca7 ruby`call_cfunc_m1(recv=0x0000000128f85fd8, argc=0, argv=0x00000001080280c8, func=(fiddle.bundle`function_call at function.c:211)) at vm_insnhelper.c:2594:12
    frame #8: 0x000000010037ef99 ruby`vm_call_cfunc_with_frame(ec=0x0000000100b069b0, reg_cfp=0x0000000108127eb0, calling=0x00007ffeefbfa030) at vm_insnhelper.c:2924:11
    frame #9: 0x0000000100377603 ruby`vm_call_cfunc(ec=0x0000000100b069b0, reg_cfp=0x0000000108127eb0, calling=0x00007ffeefbfa030) at vm_insnhelper.c:2945:12
    frame #10: 0x0000000100376f2b ruby`vm_call_method_each_type(ec=0x0000000100b069b0, cfp=0x0000000108127eb0, calling=0x00007ffeefbfa030) at vm_insnhelper.c:3414:16
    frame #11: 0x00000001003769e9 ruby`vm_call_method(ec=0x0000000100b069b0, cfp=0x0000000108127eb0, calling=0x00007ffeefbfa030) at vm_insnhelper.c:3507:20
    frame #12: 0x00000001003578f5 ruby`vm_call_general(ec=0x0000000100b069b0, reg_cfp=0x0000000108127eb0, calling=0x00007ffeefbfa030) at vm_insnhelper.c:3550:12
    frame #13: 0x000000010036d688 ruby`vm_sendish(ec=0x0000000100b069b0, reg_cfp=0x0000000108127eb0, cd=0x0000000100e2be30, block_handler=0x0000000000000000, method_explorer=mexp_search_method) at vm_insnhelper.c:4525:15
    frame #14: 0x000000010033f3de ruby`vm_exec_core(ec=0x0000000100b069b0, initial=0x0000000000000000) at insns.def:789:11
    frame #15: 0x0000000100361d6e ruby`rb_vm_exec(ec=0x0000000100b069b0, mjit_enable_p=true) at vm.c:2162:22
    frame #16: 0x00000001003884c5 ruby`invoke_bmethod(ec=0x0000000100b069b0, iseq=0x000000010781d168, self=0x0000000128f7d180, captured=0x00000001294ef620, me=0x0000000128f85f10, type=0x0000000022220101, opt_pc=0) at vm.c:1292:11
    frame #17: 0x0000000100360321 ruby`rb_vm_invoke_bmethod [inlined] invoke_iseq_block_from_c(ec=0x0000000100b069b0, captured=0x00000001294ef620, self=0x0000000128f7d180, argc=0, argv=0x00007ffeefbfcab0, kw_splat=0, passed_block_handler=0x0000000000000000, cref=0x0000000000000000, is_lambda=1, me=0x0000000128f85f10) at vm.c:1337:9
    frame #18: 0x000000010036017d ruby`rb_vm_invoke_bmethod [inlined] invoke_block_from_c_proc(ec=0x0000000100b069b0, proc=0x00000001294ef620, self=0x0000000128f7d180, argc=0, argv=0x00007ffeefbfcab0, kw_splat=0, passed_block_handler=0x0000000000000000, is_lambda=1, me=0x0000000128f85f10) at vm.c:1434
    frame #19: 0x00000001003600cf ruby`rb_vm_invoke_bmethod(ec=0x0000000100b069b0, proc=0x00000001294ef620, self=0x0000000128f7d180, argc=0, argv=0x00007ffeefbfcab0, kw_splat=0, block_handler=0x0000000000000000, me=0x0000000128f85f10) at vm.c:1470
    frame #20: 0x000000010037f3e7 ruby`vm_call_bmethod_body(ec=0x0000000100b069b0, calling=0x00007ffeefbfcd20, argv=0x00007ffeefbfcab0) at vm_insnhelper.c:2983:11
    frame #21: 0x0000000100377e8f ruby`vm_call_bmethod(ec=0x0000000100b069b0, cfp=0x0000000108127ee8, calling=0x00007ffeefbfcd20) at vm_insnhelper.c:3003:12
    frame #22: 0x00000001003770c9 ruby`vm_call_method_each_type(ec=0x0000000100b069b0, cfp=0x0000000108127ee8, calling=0x00007ffeefbfcd20) at vm_insnhelper.c:3440:16
    frame #23: 0x00000001003769e9 ruby`vm_call_method(ec=0x0000000100b069b0, cfp=0x0000000108127ee8, calling=0x00007ffeefbfcd20) at vm_insnhelper.c:3507:20
    frame #24: 0x00000001003578f5 ruby`vm_call_general(ec=0x0000000100b069b0, reg_cfp=0x0000000108127ee8, calling=0x00007ffeefbfcd20) at vm_insnhelper.c:3550:12
    frame #25: 0x000000010036d688 ruby`vm_sendish(ec=0x0000000100b069b0, reg_cfp=0x0000000108127ee8, cd=0x0000000100e2bcb0, block_handler=0x0000000000000000, method_explorer=mexp_search_method) at vm_insnhelper.c:4525:15
    frame #26: 0x000000010033f3de ruby`vm_exec_core(ec=0x0000000100b069b0, initial=0x0000000000000000) at insns.def:789:11
    frame #27: 0x0000000100361de7 ruby`rb_vm_exec(ec=0x0000000100b069b0, mjit_enable_p=true) at vm.c:2171:22
    frame #28: 0x0000000100363070 ruby`rb_iseq_eval_main(iseq=0x000000010781da28) at vm.c:2419:11
    frame #29: 0x00000001000dbefb ruby`rb_ec_exec_node(ec=0x0000000100b069b0, n=0x000000010781da28) at eval.c:317:2
    frame #30: 0x00000001000dbd83 ruby`ruby_run_node(n=0x000000010781da28) at eval.c:375:30
    frame #31: 0x00000001000036fc ruby`main(argc=4, argv=0x00007ffeefbff5f8) at main.c:47:9
    frame #32: 0x00007fff20530621 libdyld.dylib`start + 1
    frame #33: 0x00007fff20530621 libdyld.dylib`start + 1
```
