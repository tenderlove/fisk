# frozen_string_literal: true
#
# ======================================= 
# Opcodes Database license (2-clause BSD) 
# ======================================= 
#  
# Copyright (c) 2017 Facebook Inc. 
# Copyright (c) 2014-2017, Georgia Institute of Technology 
# All rights reserved. 
#  
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met: 
#  
# 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. 
#  
# 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution. 
#  
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 

require "fisk/machine"
require "fisk/machine/encoding"

class Fisk
  module Instructions
    Operand = Struct.new(:type, :input, :output)

    OPERAND_TYPES = [
      Operand.new("al", true, true),
      Operand.new("imm8", nil, nil),
      Operand.new("r8", true, true),
      Operand.new("r8", true, false),
      Operand.new("m8", true, false),
      Operand.new("ax", true, true),
      Operand.new("imm16", nil, nil),
      Operand.new("r16", true, true),
      Operand.new("r16", true, false),
      Operand.new("m16", true, false),
      Operand.new("eax", true, true),
      Operand.new("imm32", nil, nil),
      Operand.new("r32", true, true),
      Operand.new("r32", true, false),
      Operand.new("m32", true, false),
      Operand.new("rax", true, true),
      Operand.new("r64", true, true),
      Operand.new("r64", true, false),
      Operand.new("m64", true, false),
      Operand.new("m8", true, true),
      Operand.new("m16", true, true),
      Operand.new("m32", true, true),
      Operand.new("m64", true, true),
      Operand.new("xmm", true, true),
      Operand.new("xmm", true, false),
      Operand.new("m128", true, false),
      Operand.new("xmm", false, true),
      Operand.new("r32", false, true),
      Operand.new("r64", false, true),
      Operand.new("xmm0", true, false),
      Operand.new("rel32", nil, nil),
      Operand.new("al", true, false),
      Operand.new("ax", true, false),
      Operand.new("eax", true, false),
      Operand.new("rax", true, false),
      Operand.new("mm", false, true),
      Operand.new("mm", true, false),
      Operand.new("m32", false, true),
      Operand.new("r16", false, true),
      Operand.new("3", nil, nil),
      Operand.new("rel8", nil, nil),
      Operand.new("k", false, true),
      Operand.new("k", true, false),
      Operand.new("m8", false, true),
      Operand.new("m64", false, true),
      Operand.new("m16", false, true),
      Operand.new("m", true, false),
      Operand.new("r8", false, true),
      Operand.new("eax", false, true),
      Operand.new("moffs32", nil, nil),
      Operand.new("rax", false, true),
      Operand.new("moffs64", nil, nil),
      Operand.new("imm64", nil, nil),
      Operand.new("m128", false, true),
      Operand.new("mm", true, true),
      Operand.new("1", nil, nil),
      Operand.new("cl", true, false),
      Operand.new("xmm{k}{z}", false, true),
      Operand.new("m128/m64bcst", true, false),
      Operand.new("ymm{k}{z}", false, true),
      Operand.new("ymm", true, false),
      Operand.new("m256/m64bcst", true, false),
      Operand.new("zmm{k}{z}", false, true),
      Operand.new("zmm", true, false),
      Operand.new("m512/m64bcst", true, false),
      Operand.new("ymm", false, true),
      Operand.new("m256", true, false),
      Operand.new("{er}", nil, nil),
      Operand.new("m128/m32bcst", true, false),
      Operand.new("m256/m32bcst", true, false),
      Operand.new("m512/m32bcst", true, false),
      Operand.new("k{k}", false, true),
      Operand.new("{sae}", nil, nil),
      Operand.new("m128{k}{z}", false, true),
      Operand.new("m256{k}{z}", false, true),
      Operand.new("m512{k}{z}", false, true),
      Operand.new("m64/m32bcst", true, false),
      Operand.new("m64{k}{z}", false, true),
      Operand.new("m512", true, false),
      Operand.new("xmm{k}{z}", true, true),
      Operand.new("ymm{k}{z}", true, true),
      Operand.new("zmm{k}{z}", true, true),
      Operand.new("ymm", true, true),
      Operand.new("xmm{k}", true, true),
      Operand.new("vm32x", true, false),
      Operand.new("ymm{k}", true, true),
      Operand.new("zmm{k}", true, true),
      Operand.new("vm32y", true, false),
      Operand.new("vm32z", true, false),
      Operand.new("vm32y{k}", true, false),
      Operand.new("vm32z{k}", true, false),
      Operand.new("vm64z{k}", true, false),
      Operand.new("vm64x", true, false),
      Operand.new("vm64y", true, false),
      Operand.new("vm64z", true, false),
      Operand.new("m256", false, true),
      Operand.new("m512", false, true),
      Operand.new("zmm", false, true),
      Operand.new("m64{k}", false, true),
      Operand.new("m32{k}", false, true),
      Operand.new("imm4", nil, nil),
      Operand.new("m32{k}{z}", false, true),
      Operand.new("m16{k}{z}", false, true),
      Operand.new("vm32x{k}", false, true),
      Operand.new("vm32y{k}", false, true),
      Operand.new("vm32z{k}", false, true),
      Operand.new("vm64x{k}", false, true),
      Operand.new("vm64y{k}", false, true),
      Operand.new("vm64z{k}", false, true),

    ]

    def self.instruction_names
      constants - [:Operand, :OPERAND_TYPES]
    end
    autoload :ADC, "fisk/instructions/adc"
    autoload :ADCX, "fisk/instructions/adcx"
    autoload :ADD, "fisk/instructions/add"
    autoload :ADDPD, "fisk/instructions/addpd"
    autoload :ADDPS, "fisk/instructions/addps"
    autoload :ADDSD, "fisk/instructions/addsd"
    autoload :ADDSS, "fisk/instructions/addss"
    autoload :ADDSUBPD, "fisk/instructions/addsubpd"
    autoload :ADDSUBPS, "fisk/instructions/addsubps"
    autoload :ADOX, "fisk/instructions/adox"
    autoload :AESDEC, "fisk/instructions/aesdec"
    autoload :AESDECLAST, "fisk/instructions/aesdeclast"
    autoload :AESENC, "fisk/instructions/aesenc"
    autoload :AESENCLAST, "fisk/instructions/aesenclast"
    autoload :AESIMC, "fisk/instructions/aesimc"
    autoload :AESKEYGENASSIST, "fisk/instructions/aeskeygenassist"
    autoload :AND, "fisk/instructions/and"
    autoload :ANDN, "fisk/instructions/andn"
    autoload :ANDNPD, "fisk/instructions/andnpd"
    autoload :ANDNPS, "fisk/instructions/andnps"
    autoload :ANDPD, "fisk/instructions/andpd"
    autoload :ANDPS, "fisk/instructions/andps"
    autoload :BEXTR, "fisk/instructions/bextr"
    autoload :BLCFILL, "fisk/instructions/blcfill"
    autoload :BLCI, "fisk/instructions/blci"
    autoload :BLCIC, "fisk/instructions/blcic"
    autoload :BLCMSK, "fisk/instructions/blcmsk"
    autoload :BLCS, "fisk/instructions/blcs"
    autoload :BLENDPD, "fisk/instructions/blendpd"
    autoload :BLENDPS, "fisk/instructions/blendps"
    autoload :BLENDVPD, "fisk/instructions/blendvpd"
    autoload :BLENDVPS, "fisk/instructions/blendvps"
    autoload :BLSFILL, "fisk/instructions/blsfill"
    autoload :BLSI, "fisk/instructions/blsi"
    autoload :BLSIC, "fisk/instructions/blsic"
    autoload :BLSMSK, "fisk/instructions/blsmsk"
    autoload :BLSR, "fisk/instructions/blsr"
    autoload :BSF, "fisk/instructions/bsf"
    autoload :BSR, "fisk/instructions/bsr"
    autoload :BSWAP, "fisk/instructions/bswap"
    autoload :BT, "fisk/instructions/bt"
    autoload :BTC, "fisk/instructions/btc"
    autoload :BTR, "fisk/instructions/btr"
    autoload :BTS, "fisk/instructions/bts"
    autoload :BZHI, "fisk/instructions/bzhi"
    autoload :CALL, "fisk/instructions/call"
    autoload :CBW, "fisk/instructions/cbw"
    autoload :CDQ, "fisk/instructions/cdq"
    autoload :CDQE, "fisk/instructions/cdqe"
    autoload :CLC, "fisk/instructions/clc"
    autoload :CLD, "fisk/instructions/cld"
    autoload :CLFLUSH, "fisk/instructions/clflush"
    autoload :CLFLUSHOPT, "fisk/instructions/clflushopt"
    autoload :CLWB, "fisk/instructions/clwb"
    autoload :CLZERO, "fisk/instructions/clzero"
    autoload :CMC, "fisk/instructions/cmc"
    autoload :CMOVA, "fisk/instructions/cmova"
    autoload :CMOVAE, "fisk/instructions/cmovae"
    autoload :CMOVB, "fisk/instructions/cmovb"
    autoload :CMOVBE, "fisk/instructions/cmovbe"
    autoload :CMOVC, "fisk/instructions/cmovc"
    autoload :CMOVE, "fisk/instructions/cmove"
    autoload :CMOVG, "fisk/instructions/cmovg"
    autoload :CMOVGE, "fisk/instructions/cmovge"
    autoload :CMOVL, "fisk/instructions/cmovl"
    autoload :CMOVLE, "fisk/instructions/cmovle"
    autoload :CMOVNA, "fisk/instructions/cmovna"
    autoload :CMOVNAE, "fisk/instructions/cmovnae"
    autoload :CMOVNB, "fisk/instructions/cmovnb"
    autoload :CMOVNBE, "fisk/instructions/cmovnbe"
    autoload :CMOVNC, "fisk/instructions/cmovnc"
    autoload :CMOVNE, "fisk/instructions/cmovne"
    autoload :CMOVNG, "fisk/instructions/cmovng"
    autoload :CMOVNGE, "fisk/instructions/cmovnge"
    autoload :CMOVNL, "fisk/instructions/cmovnl"
    autoload :CMOVNLE, "fisk/instructions/cmovnle"
    autoload :CMOVNO, "fisk/instructions/cmovno"
    autoload :CMOVNP, "fisk/instructions/cmovnp"
    autoload :CMOVNS, "fisk/instructions/cmovns"
    autoload :CMOVNZ, "fisk/instructions/cmovnz"
    autoload :CMOVO, "fisk/instructions/cmovo"
    autoload :CMOVP, "fisk/instructions/cmovp"
    autoload :CMOVPE, "fisk/instructions/cmovpe"
    autoload :CMOVPO, "fisk/instructions/cmovpo"
    autoload :CMOVS, "fisk/instructions/cmovs"
    autoload :CMOVZ, "fisk/instructions/cmovz"
    autoload :CMP, "fisk/instructions/cmp"
    autoload :CMPPD, "fisk/instructions/cmppd"
    autoload :CMPPS, "fisk/instructions/cmpps"
    autoload :CMPSD, "fisk/instructions/cmpsd"
    autoload :CMPSS, "fisk/instructions/cmpss"
    autoload :CMPXCHG, "fisk/instructions/cmpxchg"
    autoload :CMPXCHG16B, "fisk/instructions/cmpxchg16b"
    autoload :CMPXCHG8B, "fisk/instructions/cmpxchg8b"
    autoload :COMISD, "fisk/instructions/comisd"
    autoload :COMISS, "fisk/instructions/comiss"
    autoload :CPUID, "fisk/instructions/cpuid"
    autoload :CQO, "fisk/instructions/cqo"
    autoload :CRC32, "fisk/instructions/crc32"
    autoload :CVTDQ2PD, "fisk/instructions/cvtdq2pd"
    autoload :CVTDQ2PS, "fisk/instructions/cvtdq2ps"
    autoload :CVTPD2DQ, "fisk/instructions/cvtpd2dq"
    autoload :CVTPD2PI, "fisk/instructions/cvtpd2pi"
    autoload :CVTPD2PS, "fisk/instructions/cvtpd2ps"
    autoload :CVTPI2PD, "fisk/instructions/cvtpi2pd"
    autoload :CVTPI2PS, "fisk/instructions/cvtpi2ps"
    autoload :CVTPS2DQ, "fisk/instructions/cvtps2dq"
    autoload :CVTPS2PD, "fisk/instructions/cvtps2pd"
    autoload :CVTPS2PI, "fisk/instructions/cvtps2pi"
    autoload :CVTSD2SI, "fisk/instructions/cvtsd2si"
    autoload :CVTSD2SS, "fisk/instructions/cvtsd2ss"
    autoload :CVTSI2SD, "fisk/instructions/cvtsi2sd"
    autoload :CVTSI2SS, "fisk/instructions/cvtsi2ss"
    autoload :CVTSS2SD, "fisk/instructions/cvtss2sd"
    autoload :CVTSS2SI, "fisk/instructions/cvtss2si"
    autoload :CVTTPD2DQ, "fisk/instructions/cvttpd2dq"
    autoload :CVTTPD2PI, "fisk/instructions/cvttpd2pi"
    autoload :CVTTPS2DQ, "fisk/instructions/cvttps2dq"
    autoload :CVTTPS2PI, "fisk/instructions/cvttps2pi"
    autoload :CVTTSD2SI, "fisk/instructions/cvttsd2si"
    autoload :CVTTSS2SI, "fisk/instructions/cvttss2si"
    autoload :CWD, "fisk/instructions/cwd"
    autoload :CWDE, "fisk/instructions/cwde"
    autoload :DEC, "fisk/instructions/dec"
    autoload :DIV, "fisk/instructions/div"
    autoload :DIVPD, "fisk/instructions/divpd"
    autoload :DIVPS, "fisk/instructions/divps"
    autoload :DIVSD, "fisk/instructions/divsd"
    autoload :DIVSS, "fisk/instructions/divss"
    autoload :DPPD, "fisk/instructions/dppd"
    autoload :DPPS, "fisk/instructions/dpps"
    autoload :EMMS, "fisk/instructions/emms"
    autoload :EXTRACTPS, "fisk/instructions/extractps"
    autoload :EXTRQ, "fisk/instructions/extrq"
    autoload :FEMMS, "fisk/instructions/femms"
    autoload :HADDPD, "fisk/instructions/haddpd"
    autoload :HADDPS, "fisk/instructions/haddps"
    autoload :HSUBPD, "fisk/instructions/hsubpd"
    autoload :HSUBPS, "fisk/instructions/hsubps"
    autoload :IDIV, "fisk/instructions/idiv"
    autoload :IMUL, "fisk/instructions/imul"
    autoload :INC, "fisk/instructions/inc"
    autoload :INSERTPS, "fisk/instructions/insertps"
    autoload :INSERTQ, "fisk/instructions/insertq"
    autoload :INT, "fisk/instructions/int"
    autoload :JA, "fisk/instructions/ja"
    autoload :JAE, "fisk/instructions/jae"
    autoload :JB, "fisk/instructions/jb"
    autoload :JBE, "fisk/instructions/jbe"
    autoload :JC, "fisk/instructions/jc"
    autoload :JE, "fisk/instructions/je"
    autoload :JECXZ, "fisk/instructions/jecxz"
    autoload :JG, "fisk/instructions/jg"
    autoload :JGE, "fisk/instructions/jge"
    autoload :JL, "fisk/instructions/jl"
    autoload :JLE, "fisk/instructions/jle"
    autoload :JMP, "fisk/instructions/jmp"
    autoload :JNA, "fisk/instructions/jna"
    autoload :JNAE, "fisk/instructions/jnae"
    autoload :JNB, "fisk/instructions/jnb"
    autoload :JNBE, "fisk/instructions/jnbe"
    autoload :JNC, "fisk/instructions/jnc"
    autoload :JNE, "fisk/instructions/jne"
    autoload :JNG, "fisk/instructions/jng"
    autoload :JNGE, "fisk/instructions/jnge"
    autoload :JNL, "fisk/instructions/jnl"
    autoload :JNLE, "fisk/instructions/jnle"
    autoload :JNO, "fisk/instructions/jno"
    autoload :JNP, "fisk/instructions/jnp"
    autoload :JNS, "fisk/instructions/jns"
    autoload :JNZ, "fisk/instructions/jnz"
    autoload :JO, "fisk/instructions/jo"
    autoload :JP, "fisk/instructions/jp"
    autoload :JPE, "fisk/instructions/jpe"
    autoload :JPO, "fisk/instructions/jpo"
    autoload :JRCXZ, "fisk/instructions/jrcxz"
    autoload :JS, "fisk/instructions/js"
    autoload :JZ, "fisk/instructions/jz"
    autoload :KADDB, "fisk/instructions/kaddb"
    autoload :KADDD, "fisk/instructions/kaddd"
    autoload :KADDQ, "fisk/instructions/kaddq"
    autoload :KADDW, "fisk/instructions/kaddw"
    autoload :KANDB, "fisk/instructions/kandb"
    autoload :KANDD, "fisk/instructions/kandd"
    autoload :KANDNB, "fisk/instructions/kandnb"
    autoload :KANDND, "fisk/instructions/kandnd"
    autoload :KANDNQ, "fisk/instructions/kandnq"
    autoload :KANDNW, "fisk/instructions/kandnw"
    autoload :KANDQ, "fisk/instructions/kandq"
    autoload :KANDW, "fisk/instructions/kandw"
    autoload :KMOVB, "fisk/instructions/kmovb"
    autoload :KMOVD, "fisk/instructions/kmovd"
    autoload :KMOVQ, "fisk/instructions/kmovq"
    autoload :KMOVW, "fisk/instructions/kmovw"
    autoload :KNOTB, "fisk/instructions/knotb"
    autoload :KNOTD, "fisk/instructions/knotd"
    autoload :KNOTQ, "fisk/instructions/knotq"
    autoload :KNOTW, "fisk/instructions/knotw"
    autoload :KORB, "fisk/instructions/korb"
    autoload :KORD, "fisk/instructions/kord"
    autoload :KORQ, "fisk/instructions/korq"
    autoload :KORTESTB, "fisk/instructions/kortestb"
    autoload :KORTESTD, "fisk/instructions/kortestd"
    autoload :KORTESTQ, "fisk/instructions/kortestq"
    autoload :KORTESTW, "fisk/instructions/kortestw"
    autoload :KORW, "fisk/instructions/korw"
    autoload :KSHIFTLB, "fisk/instructions/kshiftlb"
    autoload :KSHIFTLD, "fisk/instructions/kshiftld"
    autoload :KSHIFTLQ, "fisk/instructions/kshiftlq"
    autoload :KSHIFTLW, "fisk/instructions/kshiftlw"
    autoload :KSHIFTRB, "fisk/instructions/kshiftrb"
    autoload :KSHIFTRD, "fisk/instructions/kshiftrd"
    autoload :KSHIFTRQ, "fisk/instructions/kshiftrq"
    autoload :KSHIFTRW, "fisk/instructions/kshiftrw"
    autoload :KTESTB, "fisk/instructions/ktestb"
    autoload :KTESTD, "fisk/instructions/ktestd"
    autoload :KTESTQ, "fisk/instructions/ktestq"
    autoload :KTESTW, "fisk/instructions/ktestw"
    autoload :KUNPCKBW, "fisk/instructions/kunpckbw"
    autoload :KUNPCKDQ, "fisk/instructions/kunpckdq"
    autoload :KUNPCKWD, "fisk/instructions/kunpckwd"
    autoload :KXNORB, "fisk/instructions/kxnorb"
    autoload :KXNORD, "fisk/instructions/kxnord"
    autoload :KXNORQ, "fisk/instructions/kxnorq"
    autoload :KXNORW, "fisk/instructions/kxnorw"
    autoload :KXORB, "fisk/instructions/kxorb"
    autoload :KXORD, "fisk/instructions/kxord"
    autoload :KXORQ, "fisk/instructions/kxorq"
    autoload :KXORW, "fisk/instructions/kxorw"
    autoload :LDDQU, "fisk/instructions/lddqu"
    autoload :LDMXCSR, "fisk/instructions/ldmxcsr"
    autoload :LEA, "fisk/instructions/lea"
    autoload :LFENCE, "fisk/instructions/lfence"
    autoload :LZCNT, "fisk/instructions/lzcnt"
    autoload :MASKMOVDQU, "fisk/instructions/maskmovdqu"
    autoload :MASKMOVQ, "fisk/instructions/maskmovq"
    autoload :MAXPD, "fisk/instructions/maxpd"
    autoload :MAXPS, "fisk/instructions/maxps"
    autoload :MAXSD, "fisk/instructions/maxsd"
    autoload :MAXSS, "fisk/instructions/maxss"
    autoload :MFENCE, "fisk/instructions/mfence"
    autoload :MINPD, "fisk/instructions/minpd"
    autoload :MINPS, "fisk/instructions/minps"
    autoload :MINSD, "fisk/instructions/minsd"
    autoload :MINSS, "fisk/instructions/minss"
    autoload :MONITOR, "fisk/instructions/monitor"
    autoload :MONITORX, "fisk/instructions/monitorx"
    autoload :MOV, "fisk/instructions/mov"
    autoload :MOVAPD, "fisk/instructions/movapd"
    autoload :MOVAPS, "fisk/instructions/movaps"
    autoload :MOVBE, "fisk/instructions/movbe"
    autoload :MOVD, "fisk/instructions/movd"
    autoload :MOVDDUP, "fisk/instructions/movddup"
    autoload :MOVDQ2Q, "fisk/instructions/movdq2q"
    autoload :MOVDQA, "fisk/instructions/movdqa"
    autoload :MOVDQU, "fisk/instructions/movdqu"
    autoload :MOVHLPS, "fisk/instructions/movhlps"
    autoload :MOVHPD, "fisk/instructions/movhpd"
    autoload :MOVHPS, "fisk/instructions/movhps"
    autoload :MOVLHPS, "fisk/instructions/movlhps"
    autoload :MOVLPD, "fisk/instructions/movlpd"
    autoload :MOVLPS, "fisk/instructions/movlps"
    autoload :MOVMSKPD, "fisk/instructions/movmskpd"
    autoload :MOVMSKPS, "fisk/instructions/movmskps"
    autoload :MOVNTDQ, "fisk/instructions/movntdq"
    autoload :MOVNTDQA, "fisk/instructions/movntdqa"
    autoload :MOVNTI, "fisk/instructions/movnti"
    autoload :MOVNTPD, "fisk/instructions/movntpd"
    autoload :MOVNTPS, "fisk/instructions/movntps"
    autoload :MOVNTQ, "fisk/instructions/movntq"
    autoload :MOVNTSD, "fisk/instructions/movntsd"
    autoload :MOVNTSS, "fisk/instructions/movntss"
    autoload :MOVQ, "fisk/instructions/movq"
    autoload :MOVQ2DQ, "fisk/instructions/movq2dq"
    autoload :MOVSD, "fisk/instructions/movsd"
    autoload :MOVSHDUP, "fisk/instructions/movshdup"
    autoload :MOVSLDUP, "fisk/instructions/movsldup"
    autoload :MOVSS, "fisk/instructions/movss"
    autoload :MOVSX, "fisk/instructions/movsx"
    autoload :MOVSXD, "fisk/instructions/movsxd"
    autoload :MOVUPD, "fisk/instructions/movupd"
    autoload :MOVUPS, "fisk/instructions/movups"
    autoload :MOVZX, "fisk/instructions/movzx"
    autoload :MPSADBW, "fisk/instructions/mpsadbw"
    autoload :MUL, "fisk/instructions/mul"
    autoload :MULPD, "fisk/instructions/mulpd"
    autoload :MULPS, "fisk/instructions/mulps"
    autoload :MULSD, "fisk/instructions/mulsd"
    autoload :MULSS, "fisk/instructions/mulss"
    autoload :MULX, "fisk/instructions/mulx"
    autoload :MWAIT, "fisk/instructions/mwait"
    autoload :MWAITX, "fisk/instructions/mwaitx"
    autoload :NEG, "fisk/instructions/neg"
    autoload :NOP, "fisk/instructions/nop"
    autoload :NOT, "fisk/instructions/not"
    autoload :OR, "fisk/instructions/or"
    autoload :ORPD, "fisk/instructions/orpd"
    autoload :ORPS, "fisk/instructions/orps"
    autoload :PABSB, "fisk/instructions/pabsb"
    autoload :PABSD, "fisk/instructions/pabsd"
    autoload :PABSW, "fisk/instructions/pabsw"
    autoload :PACKSSDW, "fisk/instructions/packssdw"
    autoload :PACKSSWB, "fisk/instructions/packsswb"
    autoload :PACKUSDW, "fisk/instructions/packusdw"
    autoload :PACKUSWB, "fisk/instructions/packuswb"
    autoload :PADDB, "fisk/instructions/paddb"
    autoload :PADDD, "fisk/instructions/paddd"
    autoload :PADDQ, "fisk/instructions/paddq"
    autoload :PADDSB, "fisk/instructions/paddsb"
    autoload :PADDSW, "fisk/instructions/paddsw"
    autoload :PADDUSB, "fisk/instructions/paddusb"
    autoload :PADDUSW, "fisk/instructions/paddusw"
    autoload :PADDW, "fisk/instructions/paddw"
    autoload :PALIGNR, "fisk/instructions/palignr"
    autoload :PAND, "fisk/instructions/pand"
    autoload :PANDN, "fisk/instructions/pandn"
    autoload :PAUSE, "fisk/instructions/pause"
    autoload :PAVGB, "fisk/instructions/pavgb"
    autoload :PAVGUSB, "fisk/instructions/pavgusb"
    autoload :PAVGW, "fisk/instructions/pavgw"
    autoload :PBLENDVB, "fisk/instructions/pblendvb"
    autoload :PBLENDW, "fisk/instructions/pblendw"
    autoload :PCLMULQDQ, "fisk/instructions/pclmulqdq"
    autoload :PCMPEQB, "fisk/instructions/pcmpeqb"
    autoload :PCMPEQD, "fisk/instructions/pcmpeqd"
    autoload :PCMPEQQ, "fisk/instructions/pcmpeqq"
    autoload :PCMPEQW, "fisk/instructions/pcmpeqw"
    autoload :PCMPESTRI, "fisk/instructions/pcmpestri"
    autoload :PCMPESTRM, "fisk/instructions/pcmpestrm"
    autoload :PCMPGTB, "fisk/instructions/pcmpgtb"
    autoload :PCMPGTD, "fisk/instructions/pcmpgtd"
    autoload :PCMPGTQ, "fisk/instructions/pcmpgtq"
    autoload :PCMPGTW, "fisk/instructions/pcmpgtw"
    autoload :PCMPISTRI, "fisk/instructions/pcmpistri"
    autoload :PCMPISTRM, "fisk/instructions/pcmpistrm"
    autoload :PDEP, "fisk/instructions/pdep"
    autoload :PEXT, "fisk/instructions/pext"
    autoload :PEXTRB, "fisk/instructions/pextrb"
    autoload :PEXTRD, "fisk/instructions/pextrd"
    autoload :PEXTRQ, "fisk/instructions/pextrq"
    autoload :PEXTRW, "fisk/instructions/pextrw"
    autoload :PF2ID, "fisk/instructions/pf2id"
    autoload :PF2IW, "fisk/instructions/pf2iw"
    autoload :PFACC, "fisk/instructions/pfacc"
    autoload :PFADD, "fisk/instructions/pfadd"
    autoload :PFCMPEQ, "fisk/instructions/pfcmpeq"
    autoload :PFCMPGE, "fisk/instructions/pfcmpge"
    autoload :PFCMPGT, "fisk/instructions/pfcmpgt"
    autoload :PFMAX, "fisk/instructions/pfmax"
    autoload :PFMIN, "fisk/instructions/pfmin"
    autoload :PFMUL, "fisk/instructions/pfmul"
    autoload :PFNACC, "fisk/instructions/pfnacc"
    autoload :PFPNACC, "fisk/instructions/pfpnacc"
    autoload :PFRCP, "fisk/instructions/pfrcp"
    autoload :PFRCPIT1, "fisk/instructions/pfrcpit1"
    autoload :PFRCPIT2, "fisk/instructions/pfrcpit2"
    autoload :PFRSQIT1, "fisk/instructions/pfrsqit1"
    autoload :PFRSQRT, "fisk/instructions/pfrsqrt"
    autoload :PFSUB, "fisk/instructions/pfsub"
    autoload :PFSUBR, "fisk/instructions/pfsubr"
    autoload :PHADDD, "fisk/instructions/phaddd"
    autoload :PHADDSW, "fisk/instructions/phaddsw"
    autoload :PHADDW, "fisk/instructions/phaddw"
    autoload :PHMINPOSUW, "fisk/instructions/phminposuw"
    autoload :PHSUBD, "fisk/instructions/phsubd"
    autoload :PHSUBSW, "fisk/instructions/phsubsw"
    autoload :PHSUBW, "fisk/instructions/phsubw"
    autoload :PI2FD, "fisk/instructions/pi2fd"
    autoload :PI2FW, "fisk/instructions/pi2fw"
    autoload :PINSRB, "fisk/instructions/pinsrb"
    autoload :PINSRD, "fisk/instructions/pinsrd"
    autoload :PINSRQ, "fisk/instructions/pinsrq"
    autoload :PINSRW, "fisk/instructions/pinsrw"
    autoload :PMADDUBSW, "fisk/instructions/pmaddubsw"
    autoload :PMADDWD, "fisk/instructions/pmaddwd"
    autoload :PMAXSB, "fisk/instructions/pmaxsb"
    autoload :PMAXSD, "fisk/instructions/pmaxsd"
    autoload :PMAXSW, "fisk/instructions/pmaxsw"
    autoload :PMAXUB, "fisk/instructions/pmaxub"
    autoload :PMAXUD, "fisk/instructions/pmaxud"
    autoload :PMAXUW, "fisk/instructions/pmaxuw"
    autoload :PMINSB, "fisk/instructions/pminsb"
    autoload :PMINSD, "fisk/instructions/pminsd"
    autoload :PMINSW, "fisk/instructions/pminsw"
    autoload :PMINUB, "fisk/instructions/pminub"
    autoload :PMINUD, "fisk/instructions/pminud"
    autoload :PMINUW, "fisk/instructions/pminuw"
    autoload :PMOVMSKB, "fisk/instructions/pmovmskb"
    autoload :PMOVSXBD, "fisk/instructions/pmovsxbd"
    autoload :PMOVSXBQ, "fisk/instructions/pmovsxbq"
    autoload :PMOVSXBW, "fisk/instructions/pmovsxbw"
    autoload :PMOVSXDQ, "fisk/instructions/pmovsxdq"
    autoload :PMOVSXWD, "fisk/instructions/pmovsxwd"
    autoload :PMOVSXWQ, "fisk/instructions/pmovsxwq"
    autoload :PMOVZXBD, "fisk/instructions/pmovzxbd"
    autoload :PMOVZXBQ, "fisk/instructions/pmovzxbq"
    autoload :PMOVZXBW, "fisk/instructions/pmovzxbw"
    autoload :PMOVZXDQ, "fisk/instructions/pmovzxdq"
    autoload :PMOVZXWD, "fisk/instructions/pmovzxwd"
    autoload :PMOVZXWQ, "fisk/instructions/pmovzxwq"
    autoload :PMULDQ, "fisk/instructions/pmuldq"
    autoload :PMULHRSW, "fisk/instructions/pmulhrsw"
    autoload :PMULHRW, "fisk/instructions/pmulhrw"
    autoload :PMULHUW, "fisk/instructions/pmulhuw"
    autoload :PMULHW, "fisk/instructions/pmulhw"
    autoload :PMULLD, "fisk/instructions/pmulld"
    autoload :PMULLW, "fisk/instructions/pmullw"
    autoload :PMULUDQ, "fisk/instructions/pmuludq"
    autoload :POP, "fisk/instructions/pop"
    autoload :POPCNT, "fisk/instructions/popcnt"
    autoload :POR, "fisk/instructions/por"
    autoload :PREFETCH, "fisk/instructions/prefetch"
    autoload :PREFETCHNTA, "fisk/instructions/prefetchnta"
    autoload :PREFETCHT0, "fisk/instructions/prefetcht0"
    autoload :PREFETCHT1, "fisk/instructions/prefetcht1"
    autoload :PREFETCHT2, "fisk/instructions/prefetcht2"
    autoload :PREFETCHW, "fisk/instructions/prefetchw"
    autoload :PREFETCHWT1, "fisk/instructions/prefetchwt1"
    autoload :PSADBW, "fisk/instructions/psadbw"
    autoload :PSHUFB, "fisk/instructions/pshufb"
    autoload :PSHUFD, "fisk/instructions/pshufd"
    autoload :PSHUFHW, "fisk/instructions/pshufhw"
    autoload :PSHUFLW, "fisk/instructions/pshuflw"
    autoload :PSHUFW, "fisk/instructions/pshufw"
    autoload :PSIGNB, "fisk/instructions/psignb"
    autoload :PSIGND, "fisk/instructions/psignd"
    autoload :PSIGNW, "fisk/instructions/psignw"
    autoload :PSLLD, "fisk/instructions/pslld"
    autoload :PSLLDQ, "fisk/instructions/pslldq"
    autoload :PSLLQ, "fisk/instructions/psllq"
    autoload :PSLLW, "fisk/instructions/psllw"
    autoload :PSRAD, "fisk/instructions/psrad"
    autoload :PSRAW, "fisk/instructions/psraw"
    autoload :PSRLD, "fisk/instructions/psrld"
    autoload :PSRLDQ, "fisk/instructions/psrldq"
    autoload :PSRLQ, "fisk/instructions/psrlq"
    autoload :PSRLW, "fisk/instructions/psrlw"
    autoload :PSUBB, "fisk/instructions/psubb"
    autoload :PSUBD, "fisk/instructions/psubd"
    autoload :PSUBQ, "fisk/instructions/psubq"
    autoload :PSUBSB, "fisk/instructions/psubsb"
    autoload :PSUBSW, "fisk/instructions/psubsw"
    autoload :PSUBUSB, "fisk/instructions/psubusb"
    autoload :PSUBUSW, "fisk/instructions/psubusw"
    autoload :PSUBW, "fisk/instructions/psubw"
    autoload :PSWAPD, "fisk/instructions/pswapd"
    autoload :PTEST, "fisk/instructions/ptest"
    autoload :PUNPCKHBW, "fisk/instructions/punpckhbw"
    autoload :PUNPCKHDQ, "fisk/instructions/punpckhdq"
    autoload :PUNPCKHQDQ, "fisk/instructions/punpckhqdq"
    autoload :PUNPCKHWD, "fisk/instructions/punpckhwd"
    autoload :PUNPCKLBW, "fisk/instructions/punpcklbw"
    autoload :PUNPCKLDQ, "fisk/instructions/punpckldq"
    autoload :PUNPCKLQDQ, "fisk/instructions/punpcklqdq"
    autoload :PUNPCKLWD, "fisk/instructions/punpcklwd"
    autoload :PUSH, "fisk/instructions/push"
    autoload :PXOR, "fisk/instructions/pxor"
    autoload :RCL, "fisk/instructions/rcl"
    autoload :RCPPS, "fisk/instructions/rcpps"
    autoload :RCPSS, "fisk/instructions/rcpss"
    autoload :RCR, "fisk/instructions/rcr"
    autoload :RDRAND, "fisk/instructions/rdrand"
    autoload :RDSEED, "fisk/instructions/rdseed"
    autoload :RDTSC, "fisk/instructions/rdtsc"
    autoload :RDTSCP, "fisk/instructions/rdtscp"
    autoload :RET, "fisk/instructions/ret"
    autoload :ROL, "fisk/instructions/rol"
    autoload :ROR, "fisk/instructions/ror"
    autoload :RORX, "fisk/instructions/rorx"
    autoload :ROUNDPD, "fisk/instructions/roundpd"
    autoload :ROUNDPS, "fisk/instructions/roundps"
    autoload :ROUNDSD, "fisk/instructions/roundsd"
    autoload :ROUNDSS, "fisk/instructions/roundss"
    autoload :RSQRTPS, "fisk/instructions/rsqrtps"
    autoload :RSQRTSS, "fisk/instructions/rsqrtss"
    autoload :SAL, "fisk/instructions/sal"
    autoload :SAR, "fisk/instructions/sar"
    autoload :SARX, "fisk/instructions/sarx"
    autoload :SBB, "fisk/instructions/sbb"
    autoload :SETA, "fisk/instructions/seta"
    autoload :SETAE, "fisk/instructions/setae"
    autoload :SETB, "fisk/instructions/setb"
    autoload :SETBE, "fisk/instructions/setbe"
    autoload :SETC, "fisk/instructions/setc"
    autoload :SETE, "fisk/instructions/sete"
    autoload :SETG, "fisk/instructions/setg"
    autoload :SETGE, "fisk/instructions/setge"
    autoload :SETL, "fisk/instructions/setl"
    autoload :SETLE, "fisk/instructions/setle"
    autoload :SETNA, "fisk/instructions/setna"
    autoload :SETNAE, "fisk/instructions/setnae"
    autoload :SETNB, "fisk/instructions/setnb"
    autoload :SETNBE, "fisk/instructions/setnbe"
    autoload :SETNC, "fisk/instructions/setnc"
    autoload :SETNE, "fisk/instructions/setne"
    autoload :SETNG, "fisk/instructions/setng"
    autoload :SETNGE, "fisk/instructions/setnge"
    autoload :SETNL, "fisk/instructions/setnl"
    autoload :SETNLE, "fisk/instructions/setnle"
    autoload :SETNO, "fisk/instructions/setno"
    autoload :SETNP, "fisk/instructions/setnp"
    autoload :SETNS, "fisk/instructions/setns"
    autoload :SETNZ, "fisk/instructions/setnz"
    autoload :SETO, "fisk/instructions/seto"
    autoload :SETP, "fisk/instructions/setp"
    autoload :SETPE, "fisk/instructions/setpe"
    autoload :SETPO, "fisk/instructions/setpo"
    autoload :SETS, "fisk/instructions/sets"
    autoload :SETZ, "fisk/instructions/setz"
    autoload :SFENCE, "fisk/instructions/sfence"
    autoload :SHA1MSG1, "fisk/instructions/sha1msg1"
    autoload :SHA1MSG2, "fisk/instructions/sha1msg2"
    autoload :SHA1NEXTE, "fisk/instructions/sha1nexte"
    autoload :SHA1RNDS4, "fisk/instructions/sha1rnds4"
    autoload :SHA256MSG1, "fisk/instructions/sha256msg1"
    autoload :SHA256MSG2, "fisk/instructions/sha256msg2"
    autoload :SHA256RNDS2, "fisk/instructions/sha256rnds2"
    autoload :SHL, "fisk/instructions/shl"
    autoload :SHLD, "fisk/instructions/shld"
    autoload :SHLX, "fisk/instructions/shlx"
    autoload :SHR, "fisk/instructions/shr"
    autoload :SHRD, "fisk/instructions/shrd"
    autoload :SHRX, "fisk/instructions/shrx"
    autoload :SHUFPD, "fisk/instructions/shufpd"
    autoload :SHUFPS, "fisk/instructions/shufps"
    autoload :SQRTPD, "fisk/instructions/sqrtpd"
    autoload :SQRTPS, "fisk/instructions/sqrtps"
    autoload :SQRTSD, "fisk/instructions/sqrtsd"
    autoload :SQRTSS, "fisk/instructions/sqrtss"
    autoload :STC, "fisk/instructions/stc"
    autoload :STD, "fisk/instructions/std"
    autoload :STMXCSR, "fisk/instructions/stmxcsr"
    autoload :SUB, "fisk/instructions/sub"
    autoload :SUBPD, "fisk/instructions/subpd"
    autoload :SUBPS, "fisk/instructions/subps"
    autoload :SUBSD, "fisk/instructions/subsd"
    autoload :SUBSS, "fisk/instructions/subss"
    autoload :SYSCALL, "fisk/instructions/syscall"
    autoload :T1MSKC, "fisk/instructions/t1mskc"
    autoload :TEST, "fisk/instructions/test"
    autoload :TZCNT, "fisk/instructions/tzcnt"
    autoload :TZMSK, "fisk/instructions/tzmsk"
    autoload :UCOMISD, "fisk/instructions/ucomisd"
    autoload :UCOMISS, "fisk/instructions/ucomiss"
    autoload :UD2, "fisk/instructions/ud2"
    autoload :UNPCKHPD, "fisk/instructions/unpckhpd"
    autoload :UNPCKHPS, "fisk/instructions/unpckhps"
    autoload :UNPCKLPD, "fisk/instructions/unpcklpd"
    autoload :UNPCKLPS, "fisk/instructions/unpcklps"
    autoload :VADDPD, "fisk/instructions/vaddpd"
    autoload :VADDPS, "fisk/instructions/vaddps"
    autoload :VADDSD, "fisk/instructions/vaddsd"
    autoload :VADDSS, "fisk/instructions/vaddss"
    autoload :VADDSUBPD, "fisk/instructions/vaddsubpd"
    autoload :VADDSUBPS, "fisk/instructions/vaddsubps"
    autoload :VAESDEC, "fisk/instructions/vaesdec"
    autoload :VAESDECLAST, "fisk/instructions/vaesdeclast"
    autoload :VAESENC, "fisk/instructions/vaesenc"
    autoload :VAESENCLAST, "fisk/instructions/vaesenclast"
    autoload :VAESIMC, "fisk/instructions/vaesimc"
    autoload :VAESKEYGENASSIST, "fisk/instructions/vaeskeygenassist"
    autoload :VALIGND, "fisk/instructions/valignd"
    autoload :VALIGNQ, "fisk/instructions/valignq"
    autoload :VANDNPD, "fisk/instructions/vandnpd"
    autoload :VANDNPS, "fisk/instructions/vandnps"
    autoload :VANDPD, "fisk/instructions/vandpd"
    autoload :VANDPS, "fisk/instructions/vandps"
    autoload :VBLENDMPD, "fisk/instructions/vblendmpd"
    autoload :VBLENDMPS, "fisk/instructions/vblendmps"
    autoload :VBLENDPD, "fisk/instructions/vblendpd"
    autoload :VBLENDPS, "fisk/instructions/vblendps"
    autoload :VBLENDVPD, "fisk/instructions/vblendvpd"
    autoload :VBLENDVPS, "fisk/instructions/vblendvps"
    autoload :VBROADCASTF128, "fisk/instructions/vbroadcastf128"
    autoload :VBROADCASTF32X2, "fisk/instructions/vbroadcastf32x2"
    autoload :VBROADCASTF32X4, "fisk/instructions/vbroadcastf32x4"
    autoload :VBROADCASTF32X8, "fisk/instructions/vbroadcastf32x8"
    autoload :VBROADCASTF64X2, "fisk/instructions/vbroadcastf64x2"
    autoload :VBROADCASTF64X4, "fisk/instructions/vbroadcastf64x4"
    autoload :VBROADCASTI128, "fisk/instructions/vbroadcasti128"
    autoload :VBROADCASTI32X2, "fisk/instructions/vbroadcasti32x2"
    autoload :VBROADCASTI32X4, "fisk/instructions/vbroadcasti32x4"
    autoload :VBROADCASTI32X8, "fisk/instructions/vbroadcasti32x8"
    autoload :VBROADCASTI64X2, "fisk/instructions/vbroadcasti64x2"
    autoload :VBROADCASTI64X4, "fisk/instructions/vbroadcasti64x4"
    autoload :VBROADCASTSD, "fisk/instructions/vbroadcastsd"
    autoload :VBROADCASTSS, "fisk/instructions/vbroadcastss"
    autoload :VCMPPD, "fisk/instructions/vcmppd"
    autoload :VCMPPS, "fisk/instructions/vcmpps"
    autoload :VCMPSD, "fisk/instructions/vcmpsd"
    autoload :VCMPSS, "fisk/instructions/vcmpss"
    autoload :VCOMISD, "fisk/instructions/vcomisd"
    autoload :VCOMISS, "fisk/instructions/vcomiss"
    autoload :VCOMPRESSPD, "fisk/instructions/vcompresspd"
    autoload :VCOMPRESSPS, "fisk/instructions/vcompressps"
    autoload :VCVTDQ2PD, "fisk/instructions/vcvtdq2pd"
    autoload :VCVTDQ2PS, "fisk/instructions/vcvtdq2ps"
    autoload :VCVTPD2DQ, "fisk/instructions/vcvtpd2dq"
    autoload :VCVTPD2PS, "fisk/instructions/vcvtpd2ps"
    autoload :VCVTPD2QQ, "fisk/instructions/vcvtpd2qq"
    autoload :VCVTPD2UDQ, "fisk/instructions/vcvtpd2udq"
    autoload :VCVTPD2UQQ, "fisk/instructions/vcvtpd2uqq"
    autoload :VCVTPH2PS, "fisk/instructions/vcvtph2ps"
    autoload :VCVTPS2DQ, "fisk/instructions/vcvtps2dq"
    autoload :VCVTPS2PD, "fisk/instructions/vcvtps2pd"
    autoload :VCVTPS2PH, "fisk/instructions/vcvtps2ph"
    autoload :VCVTPS2QQ, "fisk/instructions/vcvtps2qq"
    autoload :VCVTPS2UDQ, "fisk/instructions/vcvtps2udq"
    autoload :VCVTPS2UQQ, "fisk/instructions/vcvtps2uqq"
    autoload :VCVTQQ2PD, "fisk/instructions/vcvtqq2pd"
    autoload :VCVTQQ2PS, "fisk/instructions/vcvtqq2ps"
    autoload :VCVTSD2SI, "fisk/instructions/vcvtsd2si"
    autoload :VCVTSD2SS, "fisk/instructions/vcvtsd2ss"
    autoload :VCVTSD2USI, "fisk/instructions/vcvtsd2usi"
    autoload :VCVTSI2SD, "fisk/instructions/vcvtsi2sd"
    autoload :VCVTSI2SS, "fisk/instructions/vcvtsi2ss"
    autoload :VCVTSS2SD, "fisk/instructions/vcvtss2sd"
    autoload :VCVTSS2SI, "fisk/instructions/vcvtss2si"
    autoload :VCVTSS2USI, "fisk/instructions/vcvtss2usi"
    autoload :VCVTTPD2DQ, "fisk/instructions/vcvttpd2dq"
    autoload :VCVTTPD2QQ, "fisk/instructions/vcvttpd2qq"
    autoload :VCVTTPD2UDQ, "fisk/instructions/vcvttpd2udq"
    autoload :VCVTTPD2UQQ, "fisk/instructions/vcvttpd2uqq"
    autoload :VCVTTPS2DQ, "fisk/instructions/vcvttps2dq"
    autoload :VCVTTPS2QQ, "fisk/instructions/vcvttps2qq"
    autoload :VCVTTPS2UDQ, "fisk/instructions/vcvttps2udq"
    autoload :VCVTTPS2UQQ, "fisk/instructions/vcvttps2uqq"
    autoload :VCVTTSD2SI, "fisk/instructions/vcvttsd2si"
    autoload :VCVTTSD2USI, "fisk/instructions/vcvttsd2usi"
    autoload :VCVTTSS2SI, "fisk/instructions/vcvttss2si"
    autoload :VCVTTSS2USI, "fisk/instructions/vcvttss2usi"
    autoload :VCVTUDQ2PD, "fisk/instructions/vcvtudq2pd"
    autoload :VCVTUDQ2PS, "fisk/instructions/vcvtudq2ps"
    autoload :VCVTUQQ2PD, "fisk/instructions/vcvtuqq2pd"
    autoload :VCVTUQQ2PS, "fisk/instructions/vcvtuqq2ps"
    autoload :VCVTUSI2SD, "fisk/instructions/vcvtusi2sd"
    autoload :VCVTUSI2SS, "fisk/instructions/vcvtusi2ss"
    autoload :VDBPSADBW, "fisk/instructions/vdbpsadbw"
    autoload :VDIVPD, "fisk/instructions/vdivpd"
    autoload :VDIVPS, "fisk/instructions/vdivps"
    autoload :VDIVSD, "fisk/instructions/vdivsd"
    autoload :VDIVSS, "fisk/instructions/vdivss"
    autoload :VDPPD, "fisk/instructions/vdppd"
    autoload :VDPPS, "fisk/instructions/vdpps"
    autoload :VEXP2PD, "fisk/instructions/vexp2pd"
    autoload :VEXP2PS, "fisk/instructions/vexp2ps"
    autoload :VEXPANDPD, "fisk/instructions/vexpandpd"
    autoload :VEXPANDPS, "fisk/instructions/vexpandps"
    autoload :VEXTRACTF128, "fisk/instructions/vextractf128"
    autoload :VEXTRACTF32X4, "fisk/instructions/vextractf32x4"
    autoload :VEXTRACTF32X8, "fisk/instructions/vextractf32x8"
    autoload :VEXTRACTF64X2, "fisk/instructions/vextractf64x2"
    autoload :VEXTRACTF64X4, "fisk/instructions/vextractf64x4"
    autoload :VEXTRACTI128, "fisk/instructions/vextracti128"
    autoload :VEXTRACTI32X4, "fisk/instructions/vextracti32x4"
    autoload :VEXTRACTI32X8, "fisk/instructions/vextracti32x8"
    autoload :VEXTRACTI64X2, "fisk/instructions/vextracti64x2"
    autoload :VEXTRACTI64X4, "fisk/instructions/vextracti64x4"
    autoload :VEXTRACTPS, "fisk/instructions/vextractps"
    autoload :VFIXUPIMMPD, "fisk/instructions/vfixupimmpd"
    autoload :VFIXUPIMMPS, "fisk/instructions/vfixupimmps"
    autoload :VFIXUPIMMSD, "fisk/instructions/vfixupimmsd"
    autoload :VFIXUPIMMSS, "fisk/instructions/vfixupimmss"
    autoload :VFMADD132PD, "fisk/instructions/vfmadd132pd"
    autoload :VFMADD132PS, "fisk/instructions/vfmadd132ps"
    autoload :VFMADD132SD, "fisk/instructions/vfmadd132sd"
    autoload :VFMADD132SS, "fisk/instructions/vfmadd132ss"
    autoload :VFMADD213PD, "fisk/instructions/vfmadd213pd"
    autoload :VFMADD213PS, "fisk/instructions/vfmadd213ps"
    autoload :VFMADD213SD, "fisk/instructions/vfmadd213sd"
    autoload :VFMADD213SS, "fisk/instructions/vfmadd213ss"
    autoload :VFMADD231PD, "fisk/instructions/vfmadd231pd"
    autoload :VFMADD231PS, "fisk/instructions/vfmadd231ps"
    autoload :VFMADD231SD, "fisk/instructions/vfmadd231sd"
    autoload :VFMADD231SS, "fisk/instructions/vfmadd231ss"
    autoload :VFMADDPD, "fisk/instructions/vfmaddpd"
    autoload :VFMADDPS, "fisk/instructions/vfmaddps"
    autoload :VFMADDSD, "fisk/instructions/vfmaddsd"
    autoload :VFMADDSS, "fisk/instructions/vfmaddss"
    autoload :VFMADDSUB132PD, "fisk/instructions/vfmaddsub132pd"
    autoload :VFMADDSUB132PS, "fisk/instructions/vfmaddsub132ps"
    autoload :VFMADDSUB213PD, "fisk/instructions/vfmaddsub213pd"
    autoload :VFMADDSUB213PS, "fisk/instructions/vfmaddsub213ps"
    autoload :VFMADDSUB231PD, "fisk/instructions/vfmaddsub231pd"
    autoload :VFMADDSUB231PS, "fisk/instructions/vfmaddsub231ps"
    autoload :VFMADDSUBPD, "fisk/instructions/vfmaddsubpd"
    autoload :VFMADDSUBPS, "fisk/instructions/vfmaddsubps"
    autoload :VFMSUB132PD, "fisk/instructions/vfmsub132pd"
    autoload :VFMSUB132PS, "fisk/instructions/vfmsub132ps"
    autoload :VFMSUB132SD, "fisk/instructions/vfmsub132sd"
    autoload :VFMSUB132SS, "fisk/instructions/vfmsub132ss"
    autoload :VFMSUB213PD, "fisk/instructions/vfmsub213pd"
    autoload :VFMSUB213PS, "fisk/instructions/vfmsub213ps"
    autoload :VFMSUB213SD, "fisk/instructions/vfmsub213sd"
    autoload :VFMSUB213SS, "fisk/instructions/vfmsub213ss"
    autoload :VFMSUB231PD, "fisk/instructions/vfmsub231pd"
    autoload :VFMSUB231PS, "fisk/instructions/vfmsub231ps"
    autoload :VFMSUB231SD, "fisk/instructions/vfmsub231sd"
    autoload :VFMSUB231SS, "fisk/instructions/vfmsub231ss"
    autoload :VFMSUBADD132PD, "fisk/instructions/vfmsubadd132pd"
    autoload :VFMSUBADD132PS, "fisk/instructions/vfmsubadd132ps"
    autoload :VFMSUBADD213PD, "fisk/instructions/vfmsubadd213pd"
    autoload :VFMSUBADD213PS, "fisk/instructions/vfmsubadd213ps"
    autoload :VFMSUBADD231PD, "fisk/instructions/vfmsubadd231pd"
    autoload :VFMSUBADD231PS, "fisk/instructions/vfmsubadd231ps"
    autoload :VFMSUBADDPD, "fisk/instructions/vfmsubaddpd"
    autoload :VFMSUBADDPS, "fisk/instructions/vfmsubaddps"
    autoload :VFMSUBPD, "fisk/instructions/vfmsubpd"
    autoload :VFMSUBPS, "fisk/instructions/vfmsubps"
    autoload :VFMSUBSD, "fisk/instructions/vfmsubsd"
    autoload :VFMSUBSS, "fisk/instructions/vfmsubss"
    autoload :VFNMADD132PD, "fisk/instructions/vfnmadd132pd"
    autoload :VFNMADD132PS, "fisk/instructions/vfnmadd132ps"
    autoload :VFNMADD132SD, "fisk/instructions/vfnmadd132sd"
    autoload :VFNMADD132SS, "fisk/instructions/vfnmadd132ss"
    autoload :VFNMADD213PD, "fisk/instructions/vfnmadd213pd"
    autoload :VFNMADD213PS, "fisk/instructions/vfnmadd213ps"
    autoload :VFNMADD213SD, "fisk/instructions/vfnmadd213sd"
    autoload :VFNMADD213SS, "fisk/instructions/vfnmadd213ss"
    autoload :VFNMADD231PD, "fisk/instructions/vfnmadd231pd"
    autoload :VFNMADD231PS, "fisk/instructions/vfnmadd231ps"
    autoload :VFNMADD231SD, "fisk/instructions/vfnmadd231sd"
    autoload :VFNMADD231SS, "fisk/instructions/vfnmadd231ss"
    autoload :VFNMADDPD, "fisk/instructions/vfnmaddpd"
    autoload :VFNMADDPS, "fisk/instructions/vfnmaddps"
    autoload :VFNMADDSD, "fisk/instructions/vfnmaddsd"
    autoload :VFNMADDSS, "fisk/instructions/vfnmaddss"
    autoload :VFNMSUB132PD, "fisk/instructions/vfnmsub132pd"
    autoload :VFNMSUB132PS, "fisk/instructions/vfnmsub132ps"
    autoload :VFNMSUB132SD, "fisk/instructions/vfnmsub132sd"
    autoload :VFNMSUB132SS, "fisk/instructions/vfnmsub132ss"
    autoload :VFNMSUB213PD, "fisk/instructions/vfnmsub213pd"
    autoload :VFNMSUB213PS, "fisk/instructions/vfnmsub213ps"
    autoload :VFNMSUB213SD, "fisk/instructions/vfnmsub213sd"
    autoload :VFNMSUB213SS, "fisk/instructions/vfnmsub213ss"
    autoload :VFNMSUB231PD, "fisk/instructions/vfnmsub231pd"
    autoload :VFNMSUB231PS, "fisk/instructions/vfnmsub231ps"
    autoload :VFNMSUB231SD, "fisk/instructions/vfnmsub231sd"
    autoload :VFNMSUB231SS, "fisk/instructions/vfnmsub231ss"
    autoload :VFNMSUBPD, "fisk/instructions/vfnmsubpd"
    autoload :VFNMSUBPS, "fisk/instructions/vfnmsubps"
    autoload :VFNMSUBSD, "fisk/instructions/vfnmsubsd"
    autoload :VFNMSUBSS, "fisk/instructions/vfnmsubss"
    autoload :VFPCLASSPD, "fisk/instructions/vfpclasspd"
    autoload :VFPCLASSPS, "fisk/instructions/vfpclassps"
    autoload :VFPCLASSSD, "fisk/instructions/vfpclasssd"
    autoload :VFPCLASSSS, "fisk/instructions/vfpclassss"
    autoload :VFRCZPD, "fisk/instructions/vfrczpd"
    autoload :VFRCZPS, "fisk/instructions/vfrczps"
    autoload :VFRCZSD, "fisk/instructions/vfrczsd"
    autoload :VFRCZSS, "fisk/instructions/vfrczss"
    autoload :VGATHERDPD, "fisk/instructions/vgatherdpd"
    autoload :VGATHERDPS, "fisk/instructions/vgatherdps"
    autoload :VGATHERPF0DPD, "fisk/instructions/vgatherpf0dpd"
    autoload :VGATHERPF0DPS, "fisk/instructions/vgatherpf0dps"
    autoload :VGATHERPF0QPD, "fisk/instructions/vgatherpf0qpd"
    autoload :VGATHERPF0QPS, "fisk/instructions/vgatherpf0qps"
    autoload :VGATHERPF1DPD, "fisk/instructions/vgatherpf1dpd"
    autoload :VGATHERPF1DPS, "fisk/instructions/vgatherpf1dps"
    autoload :VGATHERPF1QPD, "fisk/instructions/vgatherpf1qpd"
    autoload :VGATHERPF1QPS, "fisk/instructions/vgatherpf1qps"
    autoload :VGATHERQPD, "fisk/instructions/vgatherqpd"
    autoload :VGATHERQPS, "fisk/instructions/vgatherqps"
    autoload :VGETEXPPD, "fisk/instructions/vgetexppd"
    autoload :VGETEXPPS, "fisk/instructions/vgetexpps"
    autoload :VGETEXPSD, "fisk/instructions/vgetexpsd"
    autoload :VGETEXPSS, "fisk/instructions/vgetexpss"
    autoload :VGETMANTPD, "fisk/instructions/vgetmantpd"
    autoload :VGETMANTPS, "fisk/instructions/vgetmantps"
    autoload :VGETMANTSD, "fisk/instructions/vgetmantsd"
    autoload :VGETMANTSS, "fisk/instructions/vgetmantss"
    autoload :VHADDPD, "fisk/instructions/vhaddpd"
    autoload :VHADDPS, "fisk/instructions/vhaddps"
    autoload :VHSUBPD, "fisk/instructions/vhsubpd"
    autoload :VHSUBPS, "fisk/instructions/vhsubps"
    autoload :VINSERTF128, "fisk/instructions/vinsertf128"
    autoload :VINSERTF32X4, "fisk/instructions/vinsertf32x4"
    autoload :VINSERTF32X8, "fisk/instructions/vinsertf32x8"
    autoload :VINSERTF64X2, "fisk/instructions/vinsertf64x2"
    autoload :VINSERTF64X4, "fisk/instructions/vinsertf64x4"
    autoload :VINSERTI128, "fisk/instructions/vinserti128"
    autoload :VINSERTI32X4, "fisk/instructions/vinserti32x4"
    autoload :VINSERTI32X8, "fisk/instructions/vinserti32x8"
    autoload :VINSERTI64X2, "fisk/instructions/vinserti64x2"
    autoload :VINSERTI64X4, "fisk/instructions/vinserti64x4"
    autoload :VINSERTPS, "fisk/instructions/vinsertps"
    autoload :VLDDQU, "fisk/instructions/vlddqu"
    autoload :VLDMXCSR, "fisk/instructions/vldmxcsr"
    autoload :VMASKMOVDQU, "fisk/instructions/vmaskmovdqu"
    autoload :VMASKMOVPD, "fisk/instructions/vmaskmovpd"
    autoload :VMASKMOVPS, "fisk/instructions/vmaskmovps"
    autoload :VMAXPD, "fisk/instructions/vmaxpd"
    autoload :VMAXPS, "fisk/instructions/vmaxps"
    autoload :VMAXSD, "fisk/instructions/vmaxsd"
    autoload :VMAXSS, "fisk/instructions/vmaxss"
    autoload :VMINPD, "fisk/instructions/vminpd"
    autoload :VMINPS, "fisk/instructions/vminps"
    autoload :VMINSD, "fisk/instructions/vminsd"
    autoload :VMINSS, "fisk/instructions/vminss"
    autoload :VMOVAPD, "fisk/instructions/vmovapd"
    autoload :VMOVAPS, "fisk/instructions/vmovaps"
    autoload :VMOVD, "fisk/instructions/vmovd"
    autoload :VMOVDDUP, "fisk/instructions/vmovddup"
    autoload :VMOVDQA, "fisk/instructions/vmovdqa"
    autoload :VMOVDQA32, "fisk/instructions/vmovdqa32"
    autoload :VMOVDQA64, "fisk/instructions/vmovdqa64"
    autoload :VMOVDQU, "fisk/instructions/vmovdqu"
    autoload :VMOVDQU16, "fisk/instructions/vmovdqu16"
    autoload :VMOVDQU32, "fisk/instructions/vmovdqu32"
    autoload :VMOVDQU64, "fisk/instructions/vmovdqu64"
    autoload :VMOVDQU8, "fisk/instructions/vmovdqu8"
    autoload :VMOVHLPS, "fisk/instructions/vmovhlps"
    autoload :VMOVHPD, "fisk/instructions/vmovhpd"
    autoload :VMOVHPS, "fisk/instructions/vmovhps"
    autoload :VMOVLHPS, "fisk/instructions/vmovlhps"
    autoload :VMOVLPD, "fisk/instructions/vmovlpd"
    autoload :VMOVLPS, "fisk/instructions/vmovlps"
    autoload :VMOVMSKPD, "fisk/instructions/vmovmskpd"
    autoload :VMOVMSKPS, "fisk/instructions/vmovmskps"
    autoload :VMOVNTDQ, "fisk/instructions/vmovntdq"
    autoload :VMOVNTDQA, "fisk/instructions/vmovntdqa"
    autoload :VMOVNTPD, "fisk/instructions/vmovntpd"
    autoload :VMOVNTPS, "fisk/instructions/vmovntps"
    autoload :VMOVQ, "fisk/instructions/vmovq"
    autoload :VMOVSD, "fisk/instructions/vmovsd"
    autoload :VMOVSHDUP, "fisk/instructions/vmovshdup"
    autoload :VMOVSLDUP, "fisk/instructions/vmovsldup"
    autoload :VMOVSS, "fisk/instructions/vmovss"
    autoload :VMOVUPD, "fisk/instructions/vmovupd"
    autoload :VMOVUPS, "fisk/instructions/vmovups"
    autoload :VMPSADBW, "fisk/instructions/vmpsadbw"
    autoload :VMULPD, "fisk/instructions/vmulpd"
    autoload :VMULPS, "fisk/instructions/vmulps"
    autoload :VMULSD, "fisk/instructions/vmulsd"
    autoload :VMULSS, "fisk/instructions/vmulss"
    autoload :VORPD, "fisk/instructions/vorpd"
    autoload :VORPS, "fisk/instructions/vorps"
    autoload :VPABSB, "fisk/instructions/vpabsb"
    autoload :VPABSD, "fisk/instructions/vpabsd"
    autoload :VPABSQ, "fisk/instructions/vpabsq"
    autoload :VPABSW, "fisk/instructions/vpabsw"
    autoload :VPACKSSDW, "fisk/instructions/vpackssdw"
    autoload :VPACKSSWB, "fisk/instructions/vpacksswb"
    autoload :VPACKUSDW, "fisk/instructions/vpackusdw"
    autoload :VPACKUSWB, "fisk/instructions/vpackuswb"
    autoload :VPADDB, "fisk/instructions/vpaddb"
    autoload :VPADDD, "fisk/instructions/vpaddd"
    autoload :VPADDQ, "fisk/instructions/vpaddq"
    autoload :VPADDSB, "fisk/instructions/vpaddsb"
    autoload :VPADDSW, "fisk/instructions/vpaddsw"
    autoload :VPADDUSB, "fisk/instructions/vpaddusb"
    autoload :VPADDUSW, "fisk/instructions/vpaddusw"
    autoload :VPADDW, "fisk/instructions/vpaddw"
    autoload :VPALIGNR, "fisk/instructions/vpalignr"
    autoload :VPAND, "fisk/instructions/vpand"
    autoload :VPANDD, "fisk/instructions/vpandd"
    autoload :VPANDN, "fisk/instructions/vpandn"
    autoload :VPANDND, "fisk/instructions/vpandnd"
    autoload :VPANDNQ, "fisk/instructions/vpandnq"
    autoload :VPANDQ, "fisk/instructions/vpandq"
    autoload :VPAVGB, "fisk/instructions/vpavgb"
    autoload :VPAVGW, "fisk/instructions/vpavgw"
    autoload :VPBLENDD, "fisk/instructions/vpblendd"
    autoload :VPBLENDMB, "fisk/instructions/vpblendmb"
    autoload :VPBLENDMD, "fisk/instructions/vpblendmd"
    autoload :VPBLENDMQ, "fisk/instructions/vpblendmq"
    autoload :VPBLENDMW, "fisk/instructions/vpblendmw"
    autoload :VPBLENDVB, "fisk/instructions/vpblendvb"
    autoload :VPBLENDW, "fisk/instructions/vpblendw"
    autoload :VPBROADCASTB, "fisk/instructions/vpbroadcastb"
    autoload :VPBROADCASTD, "fisk/instructions/vpbroadcastd"
    autoload :VPBROADCASTMB2Q, "fisk/instructions/vpbroadcastmb2q"
    autoload :VPBROADCASTMW2D, "fisk/instructions/vpbroadcastmw2d"
    autoload :VPBROADCASTQ, "fisk/instructions/vpbroadcastq"
    autoload :VPBROADCASTW, "fisk/instructions/vpbroadcastw"
    autoload :VPCLMULQDQ, "fisk/instructions/vpclmulqdq"
    autoload :VPCMOV, "fisk/instructions/vpcmov"
    autoload :VPCMPB, "fisk/instructions/vpcmpb"
    autoload :VPCMPD, "fisk/instructions/vpcmpd"
    autoload :VPCMPEQB, "fisk/instructions/vpcmpeqb"
    autoload :VPCMPEQD, "fisk/instructions/vpcmpeqd"
    autoload :VPCMPEQQ, "fisk/instructions/vpcmpeqq"
    autoload :VPCMPEQW, "fisk/instructions/vpcmpeqw"
    autoload :VPCMPESTRI, "fisk/instructions/vpcmpestri"
    autoload :VPCMPESTRM, "fisk/instructions/vpcmpestrm"
    autoload :VPCMPGTB, "fisk/instructions/vpcmpgtb"
    autoload :VPCMPGTD, "fisk/instructions/vpcmpgtd"
    autoload :VPCMPGTQ, "fisk/instructions/vpcmpgtq"
    autoload :VPCMPGTW, "fisk/instructions/vpcmpgtw"
    autoload :VPCMPISTRI, "fisk/instructions/vpcmpistri"
    autoload :VPCMPISTRM, "fisk/instructions/vpcmpistrm"
    autoload :VPCMPQ, "fisk/instructions/vpcmpq"
    autoload :VPCMPUB, "fisk/instructions/vpcmpub"
    autoload :VPCMPUD, "fisk/instructions/vpcmpud"
    autoload :VPCMPUQ, "fisk/instructions/vpcmpuq"
    autoload :VPCMPUW, "fisk/instructions/vpcmpuw"
    autoload :VPCMPW, "fisk/instructions/vpcmpw"
    autoload :VPCOMB, "fisk/instructions/vpcomb"
    autoload :VPCOMD, "fisk/instructions/vpcomd"
    autoload :VPCOMPRESSD, "fisk/instructions/vpcompressd"
    autoload :VPCOMPRESSQ, "fisk/instructions/vpcompressq"
    autoload :VPCOMQ, "fisk/instructions/vpcomq"
    autoload :VPCOMUB, "fisk/instructions/vpcomub"
    autoload :VPCOMUD, "fisk/instructions/vpcomud"
    autoload :VPCOMUQ, "fisk/instructions/vpcomuq"
    autoload :VPCOMUW, "fisk/instructions/vpcomuw"
    autoload :VPCOMW, "fisk/instructions/vpcomw"
    autoload :VPCONFLICTD, "fisk/instructions/vpconflictd"
    autoload :VPCONFLICTQ, "fisk/instructions/vpconflictq"
    autoload :VPERM2F128, "fisk/instructions/vperm2f128"
    autoload :VPERM2I128, "fisk/instructions/vperm2i128"
    autoload :VPERMB, "fisk/instructions/vpermb"
    autoload :VPERMD, "fisk/instructions/vpermd"
    autoload :VPERMI2B, "fisk/instructions/vpermi2b"
    autoload :VPERMI2D, "fisk/instructions/vpermi2d"
    autoload :VPERMI2PD, "fisk/instructions/vpermi2pd"
    autoload :VPERMI2PS, "fisk/instructions/vpermi2ps"
    autoload :VPERMI2Q, "fisk/instructions/vpermi2q"
    autoload :VPERMI2W, "fisk/instructions/vpermi2w"
    autoload :VPERMIL2PD, "fisk/instructions/vpermil2pd"
    autoload :VPERMIL2PS, "fisk/instructions/vpermil2ps"
    autoload :VPERMILPD, "fisk/instructions/vpermilpd"
    autoload :VPERMILPS, "fisk/instructions/vpermilps"
    autoload :VPERMPD, "fisk/instructions/vpermpd"
    autoload :VPERMPS, "fisk/instructions/vpermps"
    autoload :VPERMQ, "fisk/instructions/vpermq"
    autoload :VPERMT2B, "fisk/instructions/vpermt2b"
    autoload :VPERMT2D, "fisk/instructions/vpermt2d"
    autoload :VPERMT2PD, "fisk/instructions/vpermt2pd"
    autoload :VPERMT2PS, "fisk/instructions/vpermt2ps"
    autoload :VPERMT2Q, "fisk/instructions/vpermt2q"
    autoload :VPERMT2W, "fisk/instructions/vpermt2w"
    autoload :VPERMW, "fisk/instructions/vpermw"
    autoload :VPEXPANDD, "fisk/instructions/vpexpandd"
    autoload :VPEXPANDQ, "fisk/instructions/vpexpandq"
    autoload :VPEXTRB, "fisk/instructions/vpextrb"
    autoload :VPEXTRD, "fisk/instructions/vpextrd"
    autoload :VPEXTRQ, "fisk/instructions/vpextrq"
    autoload :VPEXTRW, "fisk/instructions/vpextrw"
    autoload :VPGATHERDD, "fisk/instructions/vpgatherdd"
    autoload :VPGATHERDQ, "fisk/instructions/vpgatherdq"
    autoload :VPGATHERQD, "fisk/instructions/vpgatherqd"
    autoload :VPGATHERQQ, "fisk/instructions/vpgatherqq"
    autoload :VPHADDBD, "fisk/instructions/vphaddbd"
    autoload :VPHADDBQ, "fisk/instructions/vphaddbq"
    autoload :VPHADDBW, "fisk/instructions/vphaddbw"
    autoload :VPHADDD, "fisk/instructions/vphaddd"
    autoload :VPHADDDQ, "fisk/instructions/vphadddq"
    autoload :VPHADDSW, "fisk/instructions/vphaddsw"
    autoload :VPHADDUBD, "fisk/instructions/vphaddubd"
    autoload :VPHADDUBQ, "fisk/instructions/vphaddubq"
    autoload :VPHADDUBW, "fisk/instructions/vphaddubw"
    autoload :VPHADDUDQ, "fisk/instructions/vphaddudq"
    autoload :VPHADDUWD, "fisk/instructions/vphadduwd"
    autoload :VPHADDUWQ, "fisk/instructions/vphadduwq"
    autoload :VPHADDW, "fisk/instructions/vphaddw"
    autoload :VPHADDWD, "fisk/instructions/vphaddwd"
    autoload :VPHADDWQ, "fisk/instructions/vphaddwq"
    autoload :VPHMINPOSUW, "fisk/instructions/vphminposuw"
    autoload :VPHSUBBW, "fisk/instructions/vphsubbw"
    autoload :VPHSUBD, "fisk/instructions/vphsubd"
    autoload :VPHSUBDQ, "fisk/instructions/vphsubdq"
    autoload :VPHSUBSW, "fisk/instructions/vphsubsw"
    autoload :VPHSUBW, "fisk/instructions/vphsubw"
    autoload :VPHSUBWD, "fisk/instructions/vphsubwd"
    autoload :VPINSRB, "fisk/instructions/vpinsrb"
    autoload :VPINSRD, "fisk/instructions/vpinsrd"
    autoload :VPINSRQ, "fisk/instructions/vpinsrq"
    autoload :VPINSRW, "fisk/instructions/vpinsrw"
    autoload :VPLZCNTD, "fisk/instructions/vplzcntd"
    autoload :VPLZCNTQ, "fisk/instructions/vplzcntq"
    autoload :VPMACSDD, "fisk/instructions/vpmacsdd"
    autoload :VPMACSDQH, "fisk/instructions/vpmacsdqh"
    autoload :VPMACSDQL, "fisk/instructions/vpmacsdql"
    autoload :VPMACSSDD, "fisk/instructions/vpmacssdd"
    autoload :VPMACSSDQH, "fisk/instructions/vpmacssdqh"
    autoload :VPMACSSDQL, "fisk/instructions/vpmacssdql"
    autoload :VPMACSSWD, "fisk/instructions/vpmacsswd"
    autoload :VPMACSSWW, "fisk/instructions/vpmacssww"
    autoload :VPMACSWD, "fisk/instructions/vpmacswd"
    autoload :VPMACSWW, "fisk/instructions/vpmacsww"
    autoload :VPMADCSSWD, "fisk/instructions/vpmadcsswd"
    autoload :VPMADCSWD, "fisk/instructions/vpmadcswd"
    autoload :VPMADD52HUQ, "fisk/instructions/vpmadd52huq"
    autoload :VPMADD52LUQ, "fisk/instructions/vpmadd52luq"
    autoload :VPMADDUBSW, "fisk/instructions/vpmaddubsw"
    autoload :VPMADDWD, "fisk/instructions/vpmaddwd"
    autoload :VPMASKMOVD, "fisk/instructions/vpmaskmovd"
    autoload :VPMASKMOVQ, "fisk/instructions/vpmaskmovq"
    autoload :VPMAXSB, "fisk/instructions/vpmaxsb"
    autoload :VPMAXSD, "fisk/instructions/vpmaxsd"
    autoload :VPMAXSQ, "fisk/instructions/vpmaxsq"
    autoload :VPMAXSW, "fisk/instructions/vpmaxsw"
    autoload :VPMAXUB, "fisk/instructions/vpmaxub"
    autoload :VPMAXUD, "fisk/instructions/vpmaxud"
    autoload :VPMAXUQ, "fisk/instructions/vpmaxuq"
    autoload :VPMAXUW, "fisk/instructions/vpmaxuw"
    autoload :VPMINSB, "fisk/instructions/vpminsb"
    autoload :VPMINSD, "fisk/instructions/vpminsd"
    autoload :VPMINSQ, "fisk/instructions/vpminsq"
    autoload :VPMINSW, "fisk/instructions/vpminsw"
    autoload :VPMINUB, "fisk/instructions/vpminub"
    autoload :VPMINUD, "fisk/instructions/vpminud"
    autoload :VPMINUQ, "fisk/instructions/vpminuq"
    autoload :VPMINUW, "fisk/instructions/vpminuw"
    autoload :VPMOVB2M, "fisk/instructions/vpmovb2m"
    autoload :VPMOVD2M, "fisk/instructions/vpmovd2m"
    autoload :VPMOVDB, "fisk/instructions/vpmovdb"
    autoload :VPMOVDW, "fisk/instructions/vpmovdw"
    autoload :VPMOVM2B, "fisk/instructions/vpmovm2b"
    autoload :VPMOVM2D, "fisk/instructions/vpmovm2d"
    autoload :VPMOVM2Q, "fisk/instructions/vpmovm2q"
    autoload :VPMOVM2W, "fisk/instructions/vpmovm2w"
    autoload :VPMOVMSKB, "fisk/instructions/vpmovmskb"
    autoload :VPMOVQ2M, "fisk/instructions/vpmovq2m"
    autoload :VPMOVQB, "fisk/instructions/vpmovqb"
    autoload :VPMOVQD, "fisk/instructions/vpmovqd"
    autoload :VPMOVQW, "fisk/instructions/vpmovqw"
    autoload :VPMOVSDB, "fisk/instructions/vpmovsdb"
    autoload :VPMOVSDW, "fisk/instructions/vpmovsdw"
    autoload :VPMOVSQB, "fisk/instructions/vpmovsqb"
    autoload :VPMOVSQD, "fisk/instructions/vpmovsqd"
    autoload :VPMOVSQW, "fisk/instructions/vpmovsqw"
    autoload :VPMOVSWB, "fisk/instructions/vpmovswb"
    autoload :VPMOVSXBD, "fisk/instructions/vpmovsxbd"
    autoload :VPMOVSXBQ, "fisk/instructions/vpmovsxbq"
    autoload :VPMOVSXBW, "fisk/instructions/vpmovsxbw"
    autoload :VPMOVSXDQ, "fisk/instructions/vpmovsxdq"
    autoload :VPMOVSXWD, "fisk/instructions/vpmovsxwd"
    autoload :VPMOVSXWQ, "fisk/instructions/vpmovsxwq"
    autoload :VPMOVUSDB, "fisk/instructions/vpmovusdb"
    autoload :VPMOVUSDW, "fisk/instructions/vpmovusdw"
    autoload :VPMOVUSQB, "fisk/instructions/vpmovusqb"
    autoload :VPMOVUSQD, "fisk/instructions/vpmovusqd"
    autoload :VPMOVUSQW, "fisk/instructions/vpmovusqw"
    autoload :VPMOVUSWB, "fisk/instructions/vpmovuswb"
    autoload :VPMOVW2M, "fisk/instructions/vpmovw2m"
    autoload :VPMOVWB, "fisk/instructions/vpmovwb"
    autoload :VPMOVZXBD, "fisk/instructions/vpmovzxbd"
    autoload :VPMOVZXBQ, "fisk/instructions/vpmovzxbq"
    autoload :VPMOVZXBW, "fisk/instructions/vpmovzxbw"
    autoload :VPMOVZXDQ, "fisk/instructions/vpmovzxdq"
    autoload :VPMOVZXWD, "fisk/instructions/vpmovzxwd"
    autoload :VPMOVZXWQ, "fisk/instructions/vpmovzxwq"
    autoload :VPMULDQ, "fisk/instructions/vpmuldq"
    autoload :VPMULHRSW, "fisk/instructions/vpmulhrsw"
    autoload :VPMULHUW, "fisk/instructions/vpmulhuw"
    autoload :VPMULHW, "fisk/instructions/vpmulhw"
    autoload :VPMULLD, "fisk/instructions/vpmulld"
    autoload :VPMULLQ, "fisk/instructions/vpmullq"
    autoload :VPMULLW, "fisk/instructions/vpmullw"
    autoload :VPMULTISHIFTQB, "fisk/instructions/vpmultishiftqb"
    autoload :VPMULUDQ, "fisk/instructions/vpmuludq"
    autoload :VPOPCNTD, "fisk/instructions/vpopcntd"
    autoload :VPOPCNTQ, "fisk/instructions/vpopcntq"
    autoload :VPOR, "fisk/instructions/vpor"
    autoload :VPORD, "fisk/instructions/vpord"
    autoload :VPORQ, "fisk/instructions/vporq"
    autoload :VPPERM, "fisk/instructions/vpperm"
    autoload :VPROLD, "fisk/instructions/vprold"
    autoload :VPROLQ, "fisk/instructions/vprolq"
    autoload :VPROLVD, "fisk/instructions/vprolvd"
    autoload :VPROLVQ, "fisk/instructions/vprolvq"
    autoload :VPRORD, "fisk/instructions/vprord"
    autoload :VPRORQ, "fisk/instructions/vprorq"
    autoload :VPRORVD, "fisk/instructions/vprorvd"
    autoload :VPRORVQ, "fisk/instructions/vprorvq"
    autoload :VPROTB, "fisk/instructions/vprotb"
    autoload :VPROTD, "fisk/instructions/vprotd"
    autoload :VPROTQ, "fisk/instructions/vprotq"
    autoload :VPROTW, "fisk/instructions/vprotw"
    autoload :VPSADBW, "fisk/instructions/vpsadbw"
    autoload :VPSCATTERDD, "fisk/instructions/vpscatterdd"
    autoload :VPSCATTERDQ, "fisk/instructions/vpscatterdq"
    autoload :VPSCATTERQD, "fisk/instructions/vpscatterqd"
    autoload :VPSCATTERQQ, "fisk/instructions/vpscatterqq"
    autoload :VPSHAB, "fisk/instructions/vpshab"
    autoload :VPSHAD, "fisk/instructions/vpshad"
    autoload :VPSHAQ, "fisk/instructions/vpshaq"
    autoload :VPSHAW, "fisk/instructions/vpshaw"
    autoload :VPSHLB, "fisk/instructions/vpshlb"
    autoload :VPSHLD, "fisk/instructions/vpshld"
    autoload :VPSHLQ, "fisk/instructions/vpshlq"
    autoload :VPSHLW, "fisk/instructions/vpshlw"
    autoload :VPSHUFB, "fisk/instructions/vpshufb"
    autoload :VPSHUFD, "fisk/instructions/vpshufd"
    autoload :VPSHUFHW, "fisk/instructions/vpshufhw"
    autoload :VPSHUFLW, "fisk/instructions/vpshuflw"
    autoload :VPSIGNB, "fisk/instructions/vpsignb"
    autoload :VPSIGND, "fisk/instructions/vpsignd"
    autoload :VPSIGNW, "fisk/instructions/vpsignw"
    autoload :VPSLLD, "fisk/instructions/vpslld"
    autoload :VPSLLDQ, "fisk/instructions/vpslldq"
    autoload :VPSLLQ, "fisk/instructions/vpsllq"
    autoload :VPSLLVD, "fisk/instructions/vpsllvd"
    autoload :VPSLLVQ, "fisk/instructions/vpsllvq"
    autoload :VPSLLVW, "fisk/instructions/vpsllvw"
    autoload :VPSLLW, "fisk/instructions/vpsllw"
    autoload :VPSRAD, "fisk/instructions/vpsrad"
    autoload :VPSRAQ, "fisk/instructions/vpsraq"
    autoload :VPSRAVD, "fisk/instructions/vpsravd"
    autoload :VPSRAVQ, "fisk/instructions/vpsravq"
    autoload :VPSRAVW, "fisk/instructions/vpsravw"
    autoload :VPSRAW, "fisk/instructions/vpsraw"
    autoload :VPSRLD, "fisk/instructions/vpsrld"
    autoload :VPSRLDQ, "fisk/instructions/vpsrldq"
    autoload :VPSRLQ, "fisk/instructions/vpsrlq"
    autoload :VPSRLVD, "fisk/instructions/vpsrlvd"
    autoload :VPSRLVQ, "fisk/instructions/vpsrlvq"
    autoload :VPSRLVW, "fisk/instructions/vpsrlvw"
    autoload :VPSRLW, "fisk/instructions/vpsrlw"
    autoload :VPSUBB, "fisk/instructions/vpsubb"
    autoload :VPSUBD, "fisk/instructions/vpsubd"
    autoload :VPSUBQ, "fisk/instructions/vpsubq"
    autoload :VPSUBSB, "fisk/instructions/vpsubsb"
    autoload :VPSUBSW, "fisk/instructions/vpsubsw"
    autoload :VPSUBUSB, "fisk/instructions/vpsubusb"
    autoload :VPSUBUSW, "fisk/instructions/vpsubusw"
    autoload :VPSUBW, "fisk/instructions/vpsubw"
    autoload :VPTERNLOGD, "fisk/instructions/vpternlogd"
    autoload :VPTERNLOGQ, "fisk/instructions/vpternlogq"
    autoload :VPTEST, "fisk/instructions/vptest"
    autoload :VPTESTMB, "fisk/instructions/vptestmb"
    autoload :VPTESTMD, "fisk/instructions/vptestmd"
    autoload :VPTESTMQ, "fisk/instructions/vptestmq"
    autoload :VPTESTMW, "fisk/instructions/vptestmw"
    autoload :VPTESTNMB, "fisk/instructions/vptestnmb"
    autoload :VPTESTNMD, "fisk/instructions/vptestnmd"
    autoload :VPTESTNMQ, "fisk/instructions/vptestnmq"
    autoload :VPTESTNMW, "fisk/instructions/vptestnmw"
    autoload :VPUNPCKHBW, "fisk/instructions/vpunpckhbw"
    autoload :VPUNPCKHDQ, "fisk/instructions/vpunpckhdq"
    autoload :VPUNPCKHQDQ, "fisk/instructions/vpunpckhqdq"
    autoload :VPUNPCKHWD, "fisk/instructions/vpunpckhwd"
    autoload :VPUNPCKLBW, "fisk/instructions/vpunpcklbw"
    autoload :VPUNPCKLDQ, "fisk/instructions/vpunpckldq"
    autoload :VPUNPCKLQDQ, "fisk/instructions/vpunpcklqdq"
    autoload :VPUNPCKLWD, "fisk/instructions/vpunpcklwd"
    autoload :VPXOR, "fisk/instructions/vpxor"
    autoload :VPXORD, "fisk/instructions/vpxord"
    autoload :VPXORQ, "fisk/instructions/vpxorq"
    autoload :VRANGEPD, "fisk/instructions/vrangepd"
    autoload :VRANGEPS, "fisk/instructions/vrangeps"
    autoload :VRANGESD, "fisk/instructions/vrangesd"
    autoload :VRANGESS, "fisk/instructions/vrangess"
    autoload :VRCP14PD, "fisk/instructions/vrcp14pd"
    autoload :VRCP14PS, "fisk/instructions/vrcp14ps"
    autoload :VRCP14SD, "fisk/instructions/vrcp14sd"
    autoload :VRCP14SS, "fisk/instructions/vrcp14ss"
    autoload :VRCP28PD, "fisk/instructions/vrcp28pd"
    autoload :VRCP28PS, "fisk/instructions/vrcp28ps"
    autoload :VRCP28SD, "fisk/instructions/vrcp28sd"
    autoload :VRCP28SS, "fisk/instructions/vrcp28ss"
    autoload :VRCPPS, "fisk/instructions/vrcpps"
    autoload :VRCPSS, "fisk/instructions/vrcpss"
    autoload :VREDUCEPD, "fisk/instructions/vreducepd"
    autoload :VREDUCEPS, "fisk/instructions/vreduceps"
    autoload :VREDUCESD, "fisk/instructions/vreducesd"
    autoload :VREDUCESS, "fisk/instructions/vreducess"
    autoload :VRNDSCALEPD, "fisk/instructions/vrndscalepd"
    autoload :VRNDSCALEPS, "fisk/instructions/vrndscaleps"
    autoload :VRNDSCALESD, "fisk/instructions/vrndscalesd"
    autoload :VRNDSCALESS, "fisk/instructions/vrndscaless"
    autoload :VROUNDPD, "fisk/instructions/vroundpd"
    autoload :VROUNDPS, "fisk/instructions/vroundps"
    autoload :VROUNDSD, "fisk/instructions/vroundsd"
    autoload :VROUNDSS, "fisk/instructions/vroundss"
    autoload :VRSQRT14PD, "fisk/instructions/vrsqrt14pd"
    autoload :VRSQRT14PS, "fisk/instructions/vrsqrt14ps"
    autoload :VRSQRT14SD, "fisk/instructions/vrsqrt14sd"
    autoload :VRSQRT14SS, "fisk/instructions/vrsqrt14ss"
    autoload :VRSQRT28PD, "fisk/instructions/vrsqrt28pd"
    autoload :VRSQRT28PS, "fisk/instructions/vrsqrt28ps"
    autoload :VRSQRT28SD, "fisk/instructions/vrsqrt28sd"
    autoload :VRSQRT28SS, "fisk/instructions/vrsqrt28ss"
    autoload :VRSQRTPS, "fisk/instructions/vrsqrtps"
    autoload :VRSQRTSS, "fisk/instructions/vrsqrtss"
    autoload :VSCALEFPD, "fisk/instructions/vscalefpd"
    autoload :VSCALEFPS, "fisk/instructions/vscalefps"
    autoload :VSCALEFSD, "fisk/instructions/vscalefsd"
    autoload :VSCALEFSS, "fisk/instructions/vscalefss"
    autoload :VSCATTERDPD, "fisk/instructions/vscatterdpd"
    autoload :VSCATTERDPS, "fisk/instructions/vscatterdps"
    autoload :VSCATTERPF0DPD, "fisk/instructions/vscatterpf0dpd"
    autoload :VSCATTERPF0DPS, "fisk/instructions/vscatterpf0dps"
    autoload :VSCATTERPF0QPD, "fisk/instructions/vscatterpf0qpd"
    autoload :VSCATTERPF0QPS, "fisk/instructions/vscatterpf0qps"
    autoload :VSCATTERPF1DPD, "fisk/instructions/vscatterpf1dpd"
    autoload :VSCATTERPF1DPS, "fisk/instructions/vscatterpf1dps"
    autoload :VSCATTERPF1QPD, "fisk/instructions/vscatterpf1qpd"
    autoload :VSCATTERPF1QPS, "fisk/instructions/vscatterpf1qps"
    autoload :VSCATTERQPD, "fisk/instructions/vscatterqpd"
    autoload :VSCATTERQPS, "fisk/instructions/vscatterqps"
    autoload :VSHUFF32X4, "fisk/instructions/vshuff32x4"
    autoload :VSHUFF64X2, "fisk/instructions/vshuff64x2"
    autoload :VSHUFI32X4, "fisk/instructions/vshufi32x4"
    autoload :VSHUFI64X2, "fisk/instructions/vshufi64x2"
    autoload :VSHUFPD, "fisk/instructions/vshufpd"
    autoload :VSHUFPS, "fisk/instructions/vshufps"
    autoload :VSQRTPD, "fisk/instructions/vsqrtpd"
    autoload :VSQRTPS, "fisk/instructions/vsqrtps"
    autoload :VSQRTSD, "fisk/instructions/vsqrtsd"
    autoload :VSQRTSS, "fisk/instructions/vsqrtss"
    autoload :VSTMXCSR, "fisk/instructions/vstmxcsr"
    autoload :VSUBPD, "fisk/instructions/vsubpd"
    autoload :VSUBPS, "fisk/instructions/vsubps"
    autoload :VSUBSD, "fisk/instructions/vsubsd"
    autoload :VSUBSS, "fisk/instructions/vsubss"
    autoload :VTESTPD, "fisk/instructions/vtestpd"
    autoload :VTESTPS, "fisk/instructions/vtestps"
    autoload :VUCOMISD, "fisk/instructions/vucomisd"
    autoload :VUCOMISS, "fisk/instructions/vucomiss"
    autoload :VUNPCKHPD, "fisk/instructions/vunpckhpd"
    autoload :VUNPCKHPS, "fisk/instructions/vunpckhps"
    autoload :VUNPCKLPD, "fisk/instructions/vunpcklpd"
    autoload :VUNPCKLPS, "fisk/instructions/vunpcklps"
    autoload :VXORPD, "fisk/instructions/vxorpd"
    autoload :VXORPS, "fisk/instructions/vxorps"
    autoload :VZEROALL, "fisk/instructions/vzeroall"
    autoload :VZEROUPPER, "fisk/instructions/vzeroupper"
    autoload :XADD, "fisk/instructions/xadd"
    autoload :XCHG, "fisk/instructions/xchg"
    autoload :XGETBV, "fisk/instructions/xgetbv"
    autoload :XLATB, "fisk/instructions/xlatb"
    autoload :XOR, "fisk/instructions/xor"
    autoload :XORPD, "fisk/instructions/xorpd"
    autoload :XORPS, "fisk/instructions/xorps"
    module DSLMethods
      def adc(*params)
        gen_with_insn Fisk::Instructions::ADC, params
      end
      def adcx(*params)
        gen_with_insn Fisk::Instructions::ADCX, params
      end
      def add(*params)
        gen_with_insn Fisk::Instructions::ADD, params
      end
      def addpd(*params)
        gen_with_insn Fisk::Instructions::ADDPD, params
      end
      def addps(*params)
        gen_with_insn Fisk::Instructions::ADDPS, params
      end
      def addsd(*params)
        gen_with_insn Fisk::Instructions::ADDSD, params
      end
      def addss(*params)
        gen_with_insn Fisk::Instructions::ADDSS, params
      end
      def addsubpd(*params)
        gen_with_insn Fisk::Instructions::ADDSUBPD, params
      end
      def addsubps(*params)
        gen_with_insn Fisk::Instructions::ADDSUBPS, params
      end
      def adox(*params)
        gen_with_insn Fisk::Instructions::ADOX, params
      end
      def aesdec(*params)
        gen_with_insn Fisk::Instructions::AESDEC, params
      end
      def aesdeclast(*params)
        gen_with_insn Fisk::Instructions::AESDECLAST, params
      end
      def aesenc(*params)
        gen_with_insn Fisk::Instructions::AESENC, params
      end
      def aesenclast(*params)
        gen_with_insn Fisk::Instructions::AESENCLAST, params
      end
      def aesimc(*params)
        gen_with_insn Fisk::Instructions::AESIMC, params
      end
      def aeskeygenassist(*params)
        gen_with_insn Fisk::Instructions::AESKEYGENASSIST, params
      end
      def and(*params)
        gen_with_insn Fisk::Instructions::AND, params
      end
      def andn(*params)
        gen_with_insn Fisk::Instructions::ANDN, params
      end
      def andnpd(*params)
        gen_with_insn Fisk::Instructions::ANDNPD, params
      end
      def andnps(*params)
        gen_with_insn Fisk::Instructions::ANDNPS, params
      end
      def andpd(*params)
        gen_with_insn Fisk::Instructions::ANDPD, params
      end
      def andps(*params)
        gen_with_insn Fisk::Instructions::ANDPS, params
      end
      def bextr(*params)
        gen_with_insn Fisk::Instructions::BEXTR, params
      end
      def blcfill(*params)
        gen_with_insn Fisk::Instructions::BLCFILL, params
      end
      def blci(*params)
        gen_with_insn Fisk::Instructions::BLCI, params
      end
      def blcic(*params)
        gen_with_insn Fisk::Instructions::BLCIC, params
      end
      def blcmsk(*params)
        gen_with_insn Fisk::Instructions::BLCMSK, params
      end
      def blcs(*params)
        gen_with_insn Fisk::Instructions::BLCS, params
      end
      def blendpd(*params)
        gen_with_insn Fisk::Instructions::BLENDPD, params
      end
      def blendps(*params)
        gen_with_insn Fisk::Instructions::BLENDPS, params
      end
      def blendvpd(*params)
        gen_with_insn Fisk::Instructions::BLENDVPD, params
      end
      def blendvps(*params)
        gen_with_insn Fisk::Instructions::BLENDVPS, params
      end
      def blsfill(*params)
        gen_with_insn Fisk::Instructions::BLSFILL, params
      end
      def blsi(*params)
        gen_with_insn Fisk::Instructions::BLSI, params
      end
      def blsic(*params)
        gen_with_insn Fisk::Instructions::BLSIC, params
      end
      def blsmsk(*params)
        gen_with_insn Fisk::Instructions::BLSMSK, params
      end
      def blsr(*params)
        gen_with_insn Fisk::Instructions::BLSR, params
      end
      def bsf(*params)
        gen_with_insn Fisk::Instructions::BSF, params
      end
      def bsr(*params)
        gen_with_insn Fisk::Instructions::BSR, params
      end
      def bswap(*params)
        gen_with_insn Fisk::Instructions::BSWAP, params
      end
      def bt(*params)
        gen_with_insn Fisk::Instructions::BT, params
      end
      def btc(*params)
        gen_with_insn Fisk::Instructions::BTC, params
      end
      def btr(*params)
        gen_with_insn Fisk::Instructions::BTR, params
      end
      def bts(*params)
        gen_with_insn Fisk::Instructions::BTS, params
      end
      def bzhi(*params)
        gen_with_insn Fisk::Instructions::BZHI, params
      end
      def call(*params)
        gen_with_insn Fisk::Instructions::CALL, params
      end
      def cbw(*params)
        gen_with_insn Fisk::Instructions::CBW, params
      end
      def cdq(*params)
        gen_with_insn Fisk::Instructions::CDQ, params
      end
      def cdqe(*params)
        gen_with_insn Fisk::Instructions::CDQE, params
      end
      def clc(*params)
        gen_with_insn Fisk::Instructions::CLC, params
      end
      def cld(*params)
        gen_with_insn Fisk::Instructions::CLD, params
      end
      def clflush(*params)
        gen_with_insn Fisk::Instructions::CLFLUSH, params
      end
      def clflushopt(*params)
        gen_with_insn Fisk::Instructions::CLFLUSHOPT, params
      end
      def clwb(*params)
        gen_with_insn Fisk::Instructions::CLWB, params
      end
      def clzero(*params)
        gen_with_insn Fisk::Instructions::CLZERO, params
      end
      def cmc(*params)
        gen_with_insn Fisk::Instructions::CMC, params
      end
      def cmova(*params)
        gen_with_insn Fisk::Instructions::CMOVA, params
      end
      def cmovae(*params)
        gen_with_insn Fisk::Instructions::CMOVAE, params
      end
      def cmovb(*params)
        gen_with_insn Fisk::Instructions::CMOVB, params
      end
      def cmovbe(*params)
        gen_with_insn Fisk::Instructions::CMOVBE, params
      end
      def cmovc(*params)
        gen_with_insn Fisk::Instructions::CMOVC, params
      end
      def cmove(*params)
        gen_with_insn Fisk::Instructions::CMOVE, params
      end
      def cmovg(*params)
        gen_with_insn Fisk::Instructions::CMOVG, params
      end
      def cmovge(*params)
        gen_with_insn Fisk::Instructions::CMOVGE, params
      end
      def cmovl(*params)
        gen_with_insn Fisk::Instructions::CMOVL, params
      end
      def cmovle(*params)
        gen_with_insn Fisk::Instructions::CMOVLE, params
      end
      def cmovna(*params)
        gen_with_insn Fisk::Instructions::CMOVNA, params
      end
      def cmovnae(*params)
        gen_with_insn Fisk::Instructions::CMOVNAE, params
      end
      def cmovnb(*params)
        gen_with_insn Fisk::Instructions::CMOVNB, params
      end
      def cmovnbe(*params)
        gen_with_insn Fisk::Instructions::CMOVNBE, params
      end
      def cmovnc(*params)
        gen_with_insn Fisk::Instructions::CMOVNC, params
      end
      def cmovne(*params)
        gen_with_insn Fisk::Instructions::CMOVNE, params
      end
      def cmovng(*params)
        gen_with_insn Fisk::Instructions::CMOVNG, params
      end
      def cmovnge(*params)
        gen_with_insn Fisk::Instructions::CMOVNGE, params
      end
      def cmovnl(*params)
        gen_with_insn Fisk::Instructions::CMOVNL, params
      end
      def cmovnle(*params)
        gen_with_insn Fisk::Instructions::CMOVNLE, params
      end
      def cmovno(*params)
        gen_with_insn Fisk::Instructions::CMOVNO, params
      end
      def cmovnp(*params)
        gen_with_insn Fisk::Instructions::CMOVNP, params
      end
      def cmovns(*params)
        gen_with_insn Fisk::Instructions::CMOVNS, params
      end
      def cmovnz(*params)
        gen_with_insn Fisk::Instructions::CMOVNZ, params
      end
      def cmovo(*params)
        gen_with_insn Fisk::Instructions::CMOVO, params
      end
      def cmovp(*params)
        gen_with_insn Fisk::Instructions::CMOVP, params
      end
      def cmovpe(*params)
        gen_with_insn Fisk::Instructions::CMOVPE, params
      end
      def cmovpo(*params)
        gen_with_insn Fisk::Instructions::CMOVPO, params
      end
      def cmovs(*params)
        gen_with_insn Fisk::Instructions::CMOVS, params
      end
      def cmovz(*params)
        gen_with_insn Fisk::Instructions::CMOVZ, params
      end
      def cmp(*params)
        gen_with_insn Fisk::Instructions::CMP, params
      end
      def cmppd(*params)
        gen_with_insn Fisk::Instructions::CMPPD, params
      end
      def cmpps(*params)
        gen_with_insn Fisk::Instructions::CMPPS, params
      end
      def cmpsd(*params)
        gen_with_insn Fisk::Instructions::CMPSD, params
      end
      def cmpss(*params)
        gen_with_insn Fisk::Instructions::CMPSS, params
      end
      def cmpxchg(*params)
        gen_with_insn Fisk::Instructions::CMPXCHG, params
      end
      def cmpxchg16b(*params)
        gen_with_insn Fisk::Instructions::CMPXCHG16B, params
      end
      def cmpxchg8b(*params)
        gen_with_insn Fisk::Instructions::CMPXCHG8B, params
      end
      def comisd(*params)
        gen_with_insn Fisk::Instructions::COMISD, params
      end
      def comiss(*params)
        gen_with_insn Fisk::Instructions::COMISS, params
      end
      def cpuid(*params)
        gen_with_insn Fisk::Instructions::CPUID, params
      end
      def cqo(*params)
        gen_with_insn Fisk::Instructions::CQO, params
      end
      def crc32(*params)
        gen_with_insn Fisk::Instructions::CRC32, params
      end
      def cvtdq2pd(*params)
        gen_with_insn Fisk::Instructions::CVTDQ2PD, params
      end
      def cvtdq2ps(*params)
        gen_with_insn Fisk::Instructions::CVTDQ2PS, params
      end
      def cvtpd2dq(*params)
        gen_with_insn Fisk::Instructions::CVTPD2DQ, params
      end
      def cvtpd2pi(*params)
        gen_with_insn Fisk::Instructions::CVTPD2PI, params
      end
      def cvtpd2ps(*params)
        gen_with_insn Fisk::Instructions::CVTPD2PS, params
      end
      def cvtpi2pd(*params)
        gen_with_insn Fisk::Instructions::CVTPI2PD, params
      end
      def cvtpi2ps(*params)
        gen_with_insn Fisk::Instructions::CVTPI2PS, params
      end
      def cvtps2dq(*params)
        gen_with_insn Fisk::Instructions::CVTPS2DQ, params
      end
      def cvtps2pd(*params)
        gen_with_insn Fisk::Instructions::CVTPS2PD, params
      end
      def cvtps2pi(*params)
        gen_with_insn Fisk::Instructions::CVTPS2PI, params
      end
      def cvtsd2si(*params)
        gen_with_insn Fisk::Instructions::CVTSD2SI, params
      end
      def cvtsd2ss(*params)
        gen_with_insn Fisk::Instructions::CVTSD2SS, params
      end
      def cvtsi2sd(*params)
        gen_with_insn Fisk::Instructions::CVTSI2SD, params
      end
      def cvtsi2ss(*params)
        gen_with_insn Fisk::Instructions::CVTSI2SS, params
      end
      def cvtss2sd(*params)
        gen_with_insn Fisk::Instructions::CVTSS2SD, params
      end
      def cvtss2si(*params)
        gen_with_insn Fisk::Instructions::CVTSS2SI, params
      end
      def cvttpd2dq(*params)
        gen_with_insn Fisk::Instructions::CVTTPD2DQ, params
      end
      def cvttpd2pi(*params)
        gen_with_insn Fisk::Instructions::CVTTPD2PI, params
      end
      def cvttps2dq(*params)
        gen_with_insn Fisk::Instructions::CVTTPS2DQ, params
      end
      def cvttps2pi(*params)
        gen_with_insn Fisk::Instructions::CVTTPS2PI, params
      end
      def cvttsd2si(*params)
        gen_with_insn Fisk::Instructions::CVTTSD2SI, params
      end
      def cvttss2si(*params)
        gen_with_insn Fisk::Instructions::CVTTSS2SI, params
      end
      def cwd(*params)
        gen_with_insn Fisk::Instructions::CWD, params
      end
      def cwde(*params)
        gen_with_insn Fisk::Instructions::CWDE, params
      end
      def dec(*params)
        gen_with_insn Fisk::Instructions::DEC, params
      end
      def div(*params)
        gen_with_insn Fisk::Instructions::DIV, params
      end
      def divpd(*params)
        gen_with_insn Fisk::Instructions::DIVPD, params
      end
      def divps(*params)
        gen_with_insn Fisk::Instructions::DIVPS, params
      end
      def divsd(*params)
        gen_with_insn Fisk::Instructions::DIVSD, params
      end
      def divss(*params)
        gen_with_insn Fisk::Instructions::DIVSS, params
      end
      def dppd(*params)
        gen_with_insn Fisk::Instructions::DPPD, params
      end
      def dpps(*params)
        gen_with_insn Fisk::Instructions::DPPS, params
      end
      def emms(*params)
        gen_with_insn Fisk::Instructions::EMMS, params
      end
      def extractps(*params)
        gen_with_insn Fisk::Instructions::EXTRACTPS, params
      end
      def extrq(*params)
        gen_with_insn Fisk::Instructions::EXTRQ, params
      end
      def femms(*params)
        gen_with_insn Fisk::Instructions::FEMMS, params
      end
      def haddpd(*params)
        gen_with_insn Fisk::Instructions::HADDPD, params
      end
      def haddps(*params)
        gen_with_insn Fisk::Instructions::HADDPS, params
      end
      def hsubpd(*params)
        gen_with_insn Fisk::Instructions::HSUBPD, params
      end
      def hsubps(*params)
        gen_with_insn Fisk::Instructions::HSUBPS, params
      end
      def idiv(*params)
        gen_with_insn Fisk::Instructions::IDIV, params
      end
      def imul(*params)
        gen_with_insn Fisk::Instructions::IMUL, params
      end
      def inc(*params)
        gen_with_insn Fisk::Instructions::INC, params
      end
      def insertps(*params)
        gen_with_insn Fisk::Instructions::INSERTPS, params
      end
      def insertq(*params)
        gen_with_insn Fisk::Instructions::INSERTQ, params
      end
      def int(*params)
        gen_with_insn Fisk::Instructions::INT, params
      end
      def ja(*params)
        gen_with_insn Fisk::Instructions::JA, params
      end
      def jae(*params)
        gen_with_insn Fisk::Instructions::JAE, params
      end
      def jb(*params)
        gen_with_insn Fisk::Instructions::JB, params
      end
      def jbe(*params)
        gen_with_insn Fisk::Instructions::JBE, params
      end
      def jc(*params)
        gen_with_insn Fisk::Instructions::JC, params
      end
      def je(*params)
        gen_with_insn Fisk::Instructions::JE, params
      end
      def jecxz(*params)
        gen_with_insn Fisk::Instructions::JECXZ, params
      end
      def jg(*params)
        gen_with_insn Fisk::Instructions::JG, params
      end
      def jge(*params)
        gen_with_insn Fisk::Instructions::JGE, params
      end
      def jl(*params)
        gen_with_insn Fisk::Instructions::JL, params
      end
      def jle(*params)
        gen_with_insn Fisk::Instructions::JLE, params
      end
      def jmp(*params)
        gen_with_insn Fisk::Instructions::JMP, params
      end
      def jna(*params)
        gen_with_insn Fisk::Instructions::JNA, params
      end
      def jnae(*params)
        gen_with_insn Fisk::Instructions::JNAE, params
      end
      def jnb(*params)
        gen_with_insn Fisk::Instructions::JNB, params
      end
      def jnbe(*params)
        gen_with_insn Fisk::Instructions::JNBE, params
      end
      def jnc(*params)
        gen_with_insn Fisk::Instructions::JNC, params
      end
      def jne(*params)
        gen_with_insn Fisk::Instructions::JNE, params
      end
      def jng(*params)
        gen_with_insn Fisk::Instructions::JNG, params
      end
      def jnge(*params)
        gen_with_insn Fisk::Instructions::JNGE, params
      end
      def jnl(*params)
        gen_with_insn Fisk::Instructions::JNL, params
      end
      def jnle(*params)
        gen_with_insn Fisk::Instructions::JNLE, params
      end
      def jno(*params)
        gen_with_insn Fisk::Instructions::JNO, params
      end
      def jnp(*params)
        gen_with_insn Fisk::Instructions::JNP, params
      end
      def jns(*params)
        gen_with_insn Fisk::Instructions::JNS, params
      end
      def jnz(*params)
        gen_with_insn Fisk::Instructions::JNZ, params
      end
      def jo(*params)
        gen_with_insn Fisk::Instructions::JO, params
      end
      def jp(*params)
        gen_with_insn Fisk::Instructions::JP, params
      end
      def jpe(*params)
        gen_with_insn Fisk::Instructions::JPE, params
      end
      def jpo(*params)
        gen_with_insn Fisk::Instructions::JPO, params
      end
      def jrcxz(*params)
        gen_with_insn Fisk::Instructions::JRCXZ, params
      end
      def js(*params)
        gen_with_insn Fisk::Instructions::JS, params
      end
      def jz(*params)
        gen_with_insn Fisk::Instructions::JZ, params
      end
      def kaddb(*params)
        gen_with_insn Fisk::Instructions::KADDB, params
      end
      def kaddd(*params)
        gen_with_insn Fisk::Instructions::KADDD, params
      end
      def kaddq(*params)
        gen_with_insn Fisk::Instructions::KADDQ, params
      end
      def kaddw(*params)
        gen_with_insn Fisk::Instructions::KADDW, params
      end
      def kandb(*params)
        gen_with_insn Fisk::Instructions::KANDB, params
      end
      def kandd(*params)
        gen_with_insn Fisk::Instructions::KANDD, params
      end
      def kandnb(*params)
        gen_with_insn Fisk::Instructions::KANDNB, params
      end
      def kandnd(*params)
        gen_with_insn Fisk::Instructions::KANDND, params
      end
      def kandnq(*params)
        gen_with_insn Fisk::Instructions::KANDNQ, params
      end
      def kandnw(*params)
        gen_with_insn Fisk::Instructions::KANDNW, params
      end
      def kandq(*params)
        gen_with_insn Fisk::Instructions::KANDQ, params
      end
      def kandw(*params)
        gen_with_insn Fisk::Instructions::KANDW, params
      end
      def kmovb(*params)
        gen_with_insn Fisk::Instructions::KMOVB, params
      end
      def kmovd(*params)
        gen_with_insn Fisk::Instructions::KMOVD, params
      end
      def kmovq(*params)
        gen_with_insn Fisk::Instructions::KMOVQ, params
      end
      def kmovw(*params)
        gen_with_insn Fisk::Instructions::KMOVW, params
      end
      def knotb(*params)
        gen_with_insn Fisk::Instructions::KNOTB, params
      end
      def knotd(*params)
        gen_with_insn Fisk::Instructions::KNOTD, params
      end
      def knotq(*params)
        gen_with_insn Fisk::Instructions::KNOTQ, params
      end
      def knotw(*params)
        gen_with_insn Fisk::Instructions::KNOTW, params
      end
      def korb(*params)
        gen_with_insn Fisk::Instructions::KORB, params
      end
      def kord(*params)
        gen_with_insn Fisk::Instructions::KORD, params
      end
      def korq(*params)
        gen_with_insn Fisk::Instructions::KORQ, params
      end
      def kortestb(*params)
        gen_with_insn Fisk::Instructions::KORTESTB, params
      end
      def kortestd(*params)
        gen_with_insn Fisk::Instructions::KORTESTD, params
      end
      def kortestq(*params)
        gen_with_insn Fisk::Instructions::KORTESTQ, params
      end
      def kortestw(*params)
        gen_with_insn Fisk::Instructions::KORTESTW, params
      end
      def korw(*params)
        gen_with_insn Fisk::Instructions::KORW, params
      end
      def kshiftlb(*params)
        gen_with_insn Fisk::Instructions::KSHIFTLB, params
      end
      def kshiftld(*params)
        gen_with_insn Fisk::Instructions::KSHIFTLD, params
      end
      def kshiftlq(*params)
        gen_with_insn Fisk::Instructions::KSHIFTLQ, params
      end
      def kshiftlw(*params)
        gen_with_insn Fisk::Instructions::KSHIFTLW, params
      end
      def kshiftrb(*params)
        gen_with_insn Fisk::Instructions::KSHIFTRB, params
      end
      def kshiftrd(*params)
        gen_with_insn Fisk::Instructions::KSHIFTRD, params
      end
      def kshiftrq(*params)
        gen_with_insn Fisk::Instructions::KSHIFTRQ, params
      end
      def kshiftrw(*params)
        gen_with_insn Fisk::Instructions::KSHIFTRW, params
      end
      def ktestb(*params)
        gen_with_insn Fisk::Instructions::KTESTB, params
      end
      def ktestd(*params)
        gen_with_insn Fisk::Instructions::KTESTD, params
      end
      def ktestq(*params)
        gen_with_insn Fisk::Instructions::KTESTQ, params
      end
      def ktestw(*params)
        gen_with_insn Fisk::Instructions::KTESTW, params
      end
      def kunpckbw(*params)
        gen_with_insn Fisk::Instructions::KUNPCKBW, params
      end
      def kunpckdq(*params)
        gen_with_insn Fisk::Instructions::KUNPCKDQ, params
      end
      def kunpckwd(*params)
        gen_with_insn Fisk::Instructions::KUNPCKWD, params
      end
      def kxnorb(*params)
        gen_with_insn Fisk::Instructions::KXNORB, params
      end
      def kxnord(*params)
        gen_with_insn Fisk::Instructions::KXNORD, params
      end
      def kxnorq(*params)
        gen_with_insn Fisk::Instructions::KXNORQ, params
      end
      def kxnorw(*params)
        gen_with_insn Fisk::Instructions::KXNORW, params
      end
      def kxorb(*params)
        gen_with_insn Fisk::Instructions::KXORB, params
      end
      def kxord(*params)
        gen_with_insn Fisk::Instructions::KXORD, params
      end
      def kxorq(*params)
        gen_with_insn Fisk::Instructions::KXORQ, params
      end
      def kxorw(*params)
        gen_with_insn Fisk::Instructions::KXORW, params
      end
      def lddqu(*params)
        gen_with_insn Fisk::Instructions::LDDQU, params
      end
      def ldmxcsr(*params)
        gen_with_insn Fisk::Instructions::LDMXCSR, params
      end
      def lea(*params)
        gen_with_insn Fisk::Instructions::LEA, params
      end
      def lfence(*params)
        gen_with_insn Fisk::Instructions::LFENCE, params
      end
      def lzcnt(*params)
        gen_with_insn Fisk::Instructions::LZCNT, params
      end
      def maskmovdqu(*params)
        gen_with_insn Fisk::Instructions::MASKMOVDQU, params
      end
      def maskmovq(*params)
        gen_with_insn Fisk::Instructions::MASKMOVQ, params
      end
      def maxpd(*params)
        gen_with_insn Fisk::Instructions::MAXPD, params
      end
      def maxps(*params)
        gen_with_insn Fisk::Instructions::MAXPS, params
      end
      def maxsd(*params)
        gen_with_insn Fisk::Instructions::MAXSD, params
      end
      def maxss(*params)
        gen_with_insn Fisk::Instructions::MAXSS, params
      end
      def mfence(*params)
        gen_with_insn Fisk::Instructions::MFENCE, params
      end
      def minpd(*params)
        gen_with_insn Fisk::Instructions::MINPD, params
      end
      def minps(*params)
        gen_with_insn Fisk::Instructions::MINPS, params
      end
      def minsd(*params)
        gen_with_insn Fisk::Instructions::MINSD, params
      end
      def minss(*params)
        gen_with_insn Fisk::Instructions::MINSS, params
      end
      def monitor(*params)
        gen_with_insn Fisk::Instructions::MONITOR, params
      end
      def monitorx(*params)
        gen_with_insn Fisk::Instructions::MONITORX, params
      end
      def mov(*params)
        gen_with_insn Fisk::Instructions::MOV, params
      end
      def movapd(*params)
        gen_with_insn Fisk::Instructions::MOVAPD, params
      end
      def movaps(*params)
        gen_with_insn Fisk::Instructions::MOVAPS, params
      end
      def movbe(*params)
        gen_with_insn Fisk::Instructions::MOVBE, params
      end
      def movd(*params)
        gen_with_insn Fisk::Instructions::MOVD, params
      end
      def movddup(*params)
        gen_with_insn Fisk::Instructions::MOVDDUP, params
      end
      def movdq2q(*params)
        gen_with_insn Fisk::Instructions::MOVDQ2Q, params
      end
      def movdqa(*params)
        gen_with_insn Fisk::Instructions::MOVDQA, params
      end
      def movdqu(*params)
        gen_with_insn Fisk::Instructions::MOVDQU, params
      end
      def movhlps(*params)
        gen_with_insn Fisk::Instructions::MOVHLPS, params
      end
      def movhpd(*params)
        gen_with_insn Fisk::Instructions::MOVHPD, params
      end
      def movhps(*params)
        gen_with_insn Fisk::Instructions::MOVHPS, params
      end
      def movlhps(*params)
        gen_with_insn Fisk::Instructions::MOVLHPS, params
      end
      def movlpd(*params)
        gen_with_insn Fisk::Instructions::MOVLPD, params
      end
      def movlps(*params)
        gen_with_insn Fisk::Instructions::MOVLPS, params
      end
      def movmskpd(*params)
        gen_with_insn Fisk::Instructions::MOVMSKPD, params
      end
      def movmskps(*params)
        gen_with_insn Fisk::Instructions::MOVMSKPS, params
      end
      def movntdq(*params)
        gen_with_insn Fisk::Instructions::MOVNTDQ, params
      end
      def movntdqa(*params)
        gen_with_insn Fisk::Instructions::MOVNTDQA, params
      end
      def movnti(*params)
        gen_with_insn Fisk::Instructions::MOVNTI, params
      end
      def movntpd(*params)
        gen_with_insn Fisk::Instructions::MOVNTPD, params
      end
      def movntps(*params)
        gen_with_insn Fisk::Instructions::MOVNTPS, params
      end
      def movntq(*params)
        gen_with_insn Fisk::Instructions::MOVNTQ, params
      end
      def movntsd(*params)
        gen_with_insn Fisk::Instructions::MOVNTSD, params
      end
      def movntss(*params)
        gen_with_insn Fisk::Instructions::MOVNTSS, params
      end
      def movq(*params)
        gen_with_insn Fisk::Instructions::MOVQ, params
      end
      def movq2dq(*params)
        gen_with_insn Fisk::Instructions::MOVQ2DQ, params
      end
      def movsd(*params)
        gen_with_insn Fisk::Instructions::MOVSD, params
      end
      def movshdup(*params)
        gen_with_insn Fisk::Instructions::MOVSHDUP, params
      end
      def movsldup(*params)
        gen_with_insn Fisk::Instructions::MOVSLDUP, params
      end
      def movss(*params)
        gen_with_insn Fisk::Instructions::MOVSS, params
      end
      def movsx(*params)
        gen_with_insn Fisk::Instructions::MOVSX, params
      end
      def movsxd(*params)
        gen_with_insn Fisk::Instructions::MOVSXD, params
      end
      def movupd(*params)
        gen_with_insn Fisk::Instructions::MOVUPD, params
      end
      def movups(*params)
        gen_with_insn Fisk::Instructions::MOVUPS, params
      end
      def movzx(*params)
        gen_with_insn Fisk::Instructions::MOVZX, params
      end
      def mpsadbw(*params)
        gen_with_insn Fisk::Instructions::MPSADBW, params
      end
      def mul(*params)
        gen_with_insn Fisk::Instructions::MUL, params
      end
      def mulpd(*params)
        gen_with_insn Fisk::Instructions::MULPD, params
      end
      def mulps(*params)
        gen_with_insn Fisk::Instructions::MULPS, params
      end
      def mulsd(*params)
        gen_with_insn Fisk::Instructions::MULSD, params
      end
      def mulss(*params)
        gen_with_insn Fisk::Instructions::MULSS, params
      end
      def mulx(*params)
        gen_with_insn Fisk::Instructions::MULX, params
      end
      def mwait(*params)
        gen_with_insn Fisk::Instructions::MWAIT, params
      end
      def mwaitx(*params)
        gen_with_insn Fisk::Instructions::MWAITX, params
      end
      def neg(*params)
        gen_with_insn Fisk::Instructions::NEG, params
      end
      def nop(*params)
        gen_with_insn Fisk::Instructions::NOP, params
      end
      def not(*params)
        gen_with_insn Fisk::Instructions::NOT, params
      end
      def or(*params)
        gen_with_insn Fisk::Instructions::OR, params
      end
      def orpd(*params)
        gen_with_insn Fisk::Instructions::ORPD, params
      end
      def orps(*params)
        gen_with_insn Fisk::Instructions::ORPS, params
      end
      def pabsb(*params)
        gen_with_insn Fisk::Instructions::PABSB, params
      end
      def pabsd(*params)
        gen_with_insn Fisk::Instructions::PABSD, params
      end
      def pabsw(*params)
        gen_with_insn Fisk::Instructions::PABSW, params
      end
      def packssdw(*params)
        gen_with_insn Fisk::Instructions::PACKSSDW, params
      end
      def packsswb(*params)
        gen_with_insn Fisk::Instructions::PACKSSWB, params
      end
      def packusdw(*params)
        gen_with_insn Fisk::Instructions::PACKUSDW, params
      end
      def packuswb(*params)
        gen_with_insn Fisk::Instructions::PACKUSWB, params
      end
      def paddb(*params)
        gen_with_insn Fisk::Instructions::PADDB, params
      end
      def paddd(*params)
        gen_with_insn Fisk::Instructions::PADDD, params
      end
      def paddq(*params)
        gen_with_insn Fisk::Instructions::PADDQ, params
      end
      def paddsb(*params)
        gen_with_insn Fisk::Instructions::PADDSB, params
      end
      def paddsw(*params)
        gen_with_insn Fisk::Instructions::PADDSW, params
      end
      def paddusb(*params)
        gen_with_insn Fisk::Instructions::PADDUSB, params
      end
      def paddusw(*params)
        gen_with_insn Fisk::Instructions::PADDUSW, params
      end
      def paddw(*params)
        gen_with_insn Fisk::Instructions::PADDW, params
      end
      def palignr(*params)
        gen_with_insn Fisk::Instructions::PALIGNR, params
      end
      def pand(*params)
        gen_with_insn Fisk::Instructions::PAND, params
      end
      def pandn(*params)
        gen_with_insn Fisk::Instructions::PANDN, params
      end
      def pause(*params)
        gen_with_insn Fisk::Instructions::PAUSE, params
      end
      def pavgb(*params)
        gen_with_insn Fisk::Instructions::PAVGB, params
      end
      def pavgusb(*params)
        gen_with_insn Fisk::Instructions::PAVGUSB, params
      end
      def pavgw(*params)
        gen_with_insn Fisk::Instructions::PAVGW, params
      end
      def pblendvb(*params)
        gen_with_insn Fisk::Instructions::PBLENDVB, params
      end
      def pblendw(*params)
        gen_with_insn Fisk::Instructions::PBLENDW, params
      end
      def pclmulqdq(*params)
        gen_with_insn Fisk::Instructions::PCLMULQDQ, params
      end
      def pcmpeqb(*params)
        gen_with_insn Fisk::Instructions::PCMPEQB, params
      end
      def pcmpeqd(*params)
        gen_with_insn Fisk::Instructions::PCMPEQD, params
      end
      def pcmpeqq(*params)
        gen_with_insn Fisk::Instructions::PCMPEQQ, params
      end
      def pcmpeqw(*params)
        gen_with_insn Fisk::Instructions::PCMPEQW, params
      end
      def pcmpestri(*params)
        gen_with_insn Fisk::Instructions::PCMPESTRI, params
      end
      def pcmpestrm(*params)
        gen_with_insn Fisk::Instructions::PCMPESTRM, params
      end
      def pcmpgtb(*params)
        gen_with_insn Fisk::Instructions::PCMPGTB, params
      end
      def pcmpgtd(*params)
        gen_with_insn Fisk::Instructions::PCMPGTD, params
      end
      def pcmpgtq(*params)
        gen_with_insn Fisk::Instructions::PCMPGTQ, params
      end
      def pcmpgtw(*params)
        gen_with_insn Fisk::Instructions::PCMPGTW, params
      end
      def pcmpistri(*params)
        gen_with_insn Fisk::Instructions::PCMPISTRI, params
      end
      def pcmpistrm(*params)
        gen_with_insn Fisk::Instructions::PCMPISTRM, params
      end
      def pdep(*params)
        gen_with_insn Fisk::Instructions::PDEP, params
      end
      def pext(*params)
        gen_with_insn Fisk::Instructions::PEXT, params
      end
      def pextrb(*params)
        gen_with_insn Fisk::Instructions::PEXTRB, params
      end
      def pextrd(*params)
        gen_with_insn Fisk::Instructions::PEXTRD, params
      end
      def pextrq(*params)
        gen_with_insn Fisk::Instructions::PEXTRQ, params
      end
      def pextrw(*params)
        gen_with_insn Fisk::Instructions::PEXTRW, params
      end
      def pf2id(*params)
        gen_with_insn Fisk::Instructions::PF2ID, params
      end
      def pf2iw(*params)
        gen_with_insn Fisk::Instructions::PF2IW, params
      end
      def pfacc(*params)
        gen_with_insn Fisk::Instructions::PFACC, params
      end
      def pfadd(*params)
        gen_with_insn Fisk::Instructions::PFADD, params
      end
      def pfcmpeq(*params)
        gen_with_insn Fisk::Instructions::PFCMPEQ, params
      end
      def pfcmpge(*params)
        gen_with_insn Fisk::Instructions::PFCMPGE, params
      end
      def pfcmpgt(*params)
        gen_with_insn Fisk::Instructions::PFCMPGT, params
      end
      def pfmax(*params)
        gen_with_insn Fisk::Instructions::PFMAX, params
      end
      def pfmin(*params)
        gen_with_insn Fisk::Instructions::PFMIN, params
      end
      def pfmul(*params)
        gen_with_insn Fisk::Instructions::PFMUL, params
      end
      def pfnacc(*params)
        gen_with_insn Fisk::Instructions::PFNACC, params
      end
      def pfpnacc(*params)
        gen_with_insn Fisk::Instructions::PFPNACC, params
      end
      def pfrcp(*params)
        gen_with_insn Fisk::Instructions::PFRCP, params
      end
      def pfrcpit1(*params)
        gen_with_insn Fisk::Instructions::PFRCPIT1, params
      end
      def pfrcpit2(*params)
        gen_with_insn Fisk::Instructions::PFRCPIT2, params
      end
      def pfrsqit1(*params)
        gen_with_insn Fisk::Instructions::PFRSQIT1, params
      end
      def pfrsqrt(*params)
        gen_with_insn Fisk::Instructions::PFRSQRT, params
      end
      def pfsub(*params)
        gen_with_insn Fisk::Instructions::PFSUB, params
      end
      def pfsubr(*params)
        gen_with_insn Fisk::Instructions::PFSUBR, params
      end
      def phaddd(*params)
        gen_with_insn Fisk::Instructions::PHADDD, params
      end
      def phaddsw(*params)
        gen_with_insn Fisk::Instructions::PHADDSW, params
      end
      def phaddw(*params)
        gen_with_insn Fisk::Instructions::PHADDW, params
      end
      def phminposuw(*params)
        gen_with_insn Fisk::Instructions::PHMINPOSUW, params
      end
      def phsubd(*params)
        gen_with_insn Fisk::Instructions::PHSUBD, params
      end
      def phsubsw(*params)
        gen_with_insn Fisk::Instructions::PHSUBSW, params
      end
      def phsubw(*params)
        gen_with_insn Fisk::Instructions::PHSUBW, params
      end
      def pi2fd(*params)
        gen_with_insn Fisk::Instructions::PI2FD, params
      end
      def pi2fw(*params)
        gen_with_insn Fisk::Instructions::PI2FW, params
      end
      def pinsrb(*params)
        gen_with_insn Fisk::Instructions::PINSRB, params
      end
      def pinsrd(*params)
        gen_with_insn Fisk::Instructions::PINSRD, params
      end
      def pinsrq(*params)
        gen_with_insn Fisk::Instructions::PINSRQ, params
      end
      def pinsrw(*params)
        gen_with_insn Fisk::Instructions::PINSRW, params
      end
      def pmaddubsw(*params)
        gen_with_insn Fisk::Instructions::PMADDUBSW, params
      end
      def pmaddwd(*params)
        gen_with_insn Fisk::Instructions::PMADDWD, params
      end
      def pmaxsb(*params)
        gen_with_insn Fisk::Instructions::PMAXSB, params
      end
      def pmaxsd(*params)
        gen_with_insn Fisk::Instructions::PMAXSD, params
      end
      def pmaxsw(*params)
        gen_with_insn Fisk::Instructions::PMAXSW, params
      end
      def pmaxub(*params)
        gen_with_insn Fisk::Instructions::PMAXUB, params
      end
      def pmaxud(*params)
        gen_with_insn Fisk::Instructions::PMAXUD, params
      end
      def pmaxuw(*params)
        gen_with_insn Fisk::Instructions::PMAXUW, params
      end
      def pminsb(*params)
        gen_with_insn Fisk::Instructions::PMINSB, params
      end
      def pminsd(*params)
        gen_with_insn Fisk::Instructions::PMINSD, params
      end
      def pminsw(*params)
        gen_with_insn Fisk::Instructions::PMINSW, params
      end
      def pminub(*params)
        gen_with_insn Fisk::Instructions::PMINUB, params
      end
      def pminud(*params)
        gen_with_insn Fisk::Instructions::PMINUD, params
      end
      def pminuw(*params)
        gen_with_insn Fisk::Instructions::PMINUW, params
      end
      def pmovmskb(*params)
        gen_with_insn Fisk::Instructions::PMOVMSKB, params
      end
      def pmovsxbd(*params)
        gen_with_insn Fisk::Instructions::PMOVSXBD, params
      end
      def pmovsxbq(*params)
        gen_with_insn Fisk::Instructions::PMOVSXBQ, params
      end
      def pmovsxbw(*params)
        gen_with_insn Fisk::Instructions::PMOVSXBW, params
      end
      def pmovsxdq(*params)
        gen_with_insn Fisk::Instructions::PMOVSXDQ, params
      end
      def pmovsxwd(*params)
        gen_with_insn Fisk::Instructions::PMOVSXWD, params
      end
      def pmovsxwq(*params)
        gen_with_insn Fisk::Instructions::PMOVSXWQ, params
      end
      def pmovzxbd(*params)
        gen_with_insn Fisk::Instructions::PMOVZXBD, params
      end
      def pmovzxbq(*params)
        gen_with_insn Fisk::Instructions::PMOVZXBQ, params
      end
      def pmovzxbw(*params)
        gen_with_insn Fisk::Instructions::PMOVZXBW, params
      end
      def pmovzxdq(*params)
        gen_with_insn Fisk::Instructions::PMOVZXDQ, params
      end
      def pmovzxwd(*params)
        gen_with_insn Fisk::Instructions::PMOVZXWD, params
      end
      def pmovzxwq(*params)
        gen_with_insn Fisk::Instructions::PMOVZXWQ, params
      end
      def pmuldq(*params)
        gen_with_insn Fisk::Instructions::PMULDQ, params
      end
      def pmulhrsw(*params)
        gen_with_insn Fisk::Instructions::PMULHRSW, params
      end
      def pmulhrw(*params)
        gen_with_insn Fisk::Instructions::PMULHRW, params
      end
      def pmulhuw(*params)
        gen_with_insn Fisk::Instructions::PMULHUW, params
      end
      def pmulhw(*params)
        gen_with_insn Fisk::Instructions::PMULHW, params
      end
      def pmulld(*params)
        gen_with_insn Fisk::Instructions::PMULLD, params
      end
      def pmullw(*params)
        gen_with_insn Fisk::Instructions::PMULLW, params
      end
      def pmuludq(*params)
        gen_with_insn Fisk::Instructions::PMULUDQ, params
      end
      def pop(*params)
        gen_with_insn Fisk::Instructions::POP, params
      end
      def popcnt(*params)
        gen_with_insn Fisk::Instructions::POPCNT, params
      end
      def por(*params)
        gen_with_insn Fisk::Instructions::POR, params
      end
      def prefetch(*params)
        gen_with_insn Fisk::Instructions::PREFETCH, params
      end
      def prefetchnta(*params)
        gen_with_insn Fisk::Instructions::PREFETCHNTA, params
      end
      def prefetcht0(*params)
        gen_with_insn Fisk::Instructions::PREFETCHT0, params
      end
      def prefetcht1(*params)
        gen_with_insn Fisk::Instructions::PREFETCHT1, params
      end
      def prefetcht2(*params)
        gen_with_insn Fisk::Instructions::PREFETCHT2, params
      end
      def prefetchw(*params)
        gen_with_insn Fisk::Instructions::PREFETCHW, params
      end
      def prefetchwt1(*params)
        gen_with_insn Fisk::Instructions::PREFETCHWT1, params
      end
      def psadbw(*params)
        gen_with_insn Fisk::Instructions::PSADBW, params
      end
      def pshufb(*params)
        gen_with_insn Fisk::Instructions::PSHUFB, params
      end
      def pshufd(*params)
        gen_with_insn Fisk::Instructions::PSHUFD, params
      end
      def pshufhw(*params)
        gen_with_insn Fisk::Instructions::PSHUFHW, params
      end
      def pshuflw(*params)
        gen_with_insn Fisk::Instructions::PSHUFLW, params
      end
      def pshufw(*params)
        gen_with_insn Fisk::Instructions::PSHUFW, params
      end
      def psignb(*params)
        gen_with_insn Fisk::Instructions::PSIGNB, params
      end
      def psignd(*params)
        gen_with_insn Fisk::Instructions::PSIGND, params
      end
      def psignw(*params)
        gen_with_insn Fisk::Instructions::PSIGNW, params
      end
      def pslld(*params)
        gen_with_insn Fisk::Instructions::PSLLD, params
      end
      def pslldq(*params)
        gen_with_insn Fisk::Instructions::PSLLDQ, params
      end
      def psllq(*params)
        gen_with_insn Fisk::Instructions::PSLLQ, params
      end
      def psllw(*params)
        gen_with_insn Fisk::Instructions::PSLLW, params
      end
      def psrad(*params)
        gen_with_insn Fisk::Instructions::PSRAD, params
      end
      def psraw(*params)
        gen_with_insn Fisk::Instructions::PSRAW, params
      end
      def psrld(*params)
        gen_with_insn Fisk::Instructions::PSRLD, params
      end
      def psrldq(*params)
        gen_with_insn Fisk::Instructions::PSRLDQ, params
      end
      def psrlq(*params)
        gen_with_insn Fisk::Instructions::PSRLQ, params
      end
      def psrlw(*params)
        gen_with_insn Fisk::Instructions::PSRLW, params
      end
      def psubb(*params)
        gen_with_insn Fisk::Instructions::PSUBB, params
      end
      def psubd(*params)
        gen_with_insn Fisk::Instructions::PSUBD, params
      end
      def psubq(*params)
        gen_with_insn Fisk::Instructions::PSUBQ, params
      end
      def psubsb(*params)
        gen_with_insn Fisk::Instructions::PSUBSB, params
      end
      def psubsw(*params)
        gen_with_insn Fisk::Instructions::PSUBSW, params
      end
      def psubusb(*params)
        gen_with_insn Fisk::Instructions::PSUBUSB, params
      end
      def psubusw(*params)
        gen_with_insn Fisk::Instructions::PSUBUSW, params
      end
      def psubw(*params)
        gen_with_insn Fisk::Instructions::PSUBW, params
      end
      def pswapd(*params)
        gen_with_insn Fisk::Instructions::PSWAPD, params
      end
      def ptest(*params)
        gen_with_insn Fisk::Instructions::PTEST, params
      end
      def punpckhbw(*params)
        gen_with_insn Fisk::Instructions::PUNPCKHBW, params
      end
      def punpckhdq(*params)
        gen_with_insn Fisk::Instructions::PUNPCKHDQ, params
      end
      def punpckhqdq(*params)
        gen_with_insn Fisk::Instructions::PUNPCKHQDQ, params
      end
      def punpckhwd(*params)
        gen_with_insn Fisk::Instructions::PUNPCKHWD, params
      end
      def punpcklbw(*params)
        gen_with_insn Fisk::Instructions::PUNPCKLBW, params
      end
      def punpckldq(*params)
        gen_with_insn Fisk::Instructions::PUNPCKLDQ, params
      end
      def punpcklqdq(*params)
        gen_with_insn Fisk::Instructions::PUNPCKLQDQ, params
      end
      def punpcklwd(*params)
        gen_with_insn Fisk::Instructions::PUNPCKLWD, params
      end
      def push(*params)
        gen_with_insn Fisk::Instructions::PUSH, params
      end
      def pxor(*params)
        gen_with_insn Fisk::Instructions::PXOR, params
      end
      def rcl(*params)
        gen_with_insn Fisk::Instructions::RCL, params
      end
      def rcpps(*params)
        gen_with_insn Fisk::Instructions::RCPPS, params
      end
      def rcpss(*params)
        gen_with_insn Fisk::Instructions::RCPSS, params
      end
      def rcr(*params)
        gen_with_insn Fisk::Instructions::RCR, params
      end
      def rdrand(*params)
        gen_with_insn Fisk::Instructions::RDRAND, params
      end
      def rdseed(*params)
        gen_with_insn Fisk::Instructions::RDSEED, params
      end
      def rdtsc(*params)
        gen_with_insn Fisk::Instructions::RDTSC, params
      end
      def rdtscp(*params)
        gen_with_insn Fisk::Instructions::RDTSCP, params
      end
      def ret(*params)
        gen_with_insn Fisk::Instructions::RET, params
      end
      def rol(*params)
        gen_with_insn Fisk::Instructions::ROL, params
      end
      def ror(*params)
        gen_with_insn Fisk::Instructions::ROR, params
      end
      def rorx(*params)
        gen_with_insn Fisk::Instructions::RORX, params
      end
      def roundpd(*params)
        gen_with_insn Fisk::Instructions::ROUNDPD, params
      end
      def roundps(*params)
        gen_with_insn Fisk::Instructions::ROUNDPS, params
      end
      def roundsd(*params)
        gen_with_insn Fisk::Instructions::ROUNDSD, params
      end
      def roundss(*params)
        gen_with_insn Fisk::Instructions::ROUNDSS, params
      end
      def rsqrtps(*params)
        gen_with_insn Fisk::Instructions::RSQRTPS, params
      end
      def rsqrtss(*params)
        gen_with_insn Fisk::Instructions::RSQRTSS, params
      end
      def sal(*params)
        gen_with_insn Fisk::Instructions::SAL, params
      end
      def sar(*params)
        gen_with_insn Fisk::Instructions::SAR, params
      end
      def sarx(*params)
        gen_with_insn Fisk::Instructions::SARX, params
      end
      def sbb(*params)
        gen_with_insn Fisk::Instructions::SBB, params
      end
      def seta(*params)
        gen_with_insn Fisk::Instructions::SETA, params
      end
      def setae(*params)
        gen_with_insn Fisk::Instructions::SETAE, params
      end
      def setb(*params)
        gen_with_insn Fisk::Instructions::SETB, params
      end
      def setbe(*params)
        gen_with_insn Fisk::Instructions::SETBE, params
      end
      def setc(*params)
        gen_with_insn Fisk::Instructions::SETC, params
      end
      def sete(*params)
        gen_with_insn Fisk::Instructions::SETE, params
      end
      def setg(*params)
        gen_with_insn Fisk::Instructions::SETG, params
      end
      def setge(*params)
        gen_with_insn Fisk::Instructions::SETGE, params
      end
      def setl(*params)
        gen_with_insn Fisk::Instructions::SETL, params
      end
      def setle(*params)
        gen_with_insn Fisk::Instructions::SETLE, params
      end
      def setna(*params)
        gen_with_insn Fisk::Instructions::SETNA, params
      end
      def setnae(*params)
        gen_with_insn Fisk::Instructions::SETNAE, params
      end
      def setnb(*params)
        gen_with_insn Fisk::Instructions::SETNB, params
      end
      def setnbe(*params)
        gen_with_insn Fisk::Instructions::SETNBE, params
      end
      def setnc(*params)
        gen_with_insn Fisk::Instructions::SETNC, params
      end
      def setne(*params)
        gen_with_insn Fisk::Instructions::SETNE, params
      end
      def setng(*params)
        gen_with_insn Fisk::Instructions::SETNG, params
      end
      def setnge(*params)
        gen_with_insn Fisk::Instructions::SETNGE, params
      end
      def setnl(*params)
        gen_with_insn Fisk::Instructions::SETNL, params
      end
      def setnle(*params)
        gen_with_insn Fisk::Instructions::SETNLE, params
      end
      def setno(*params)
        gen_with_insn Fisk::Instructions::SETNO, params
      end
      def setnp(*params)
        gen_with_insn Fisk::Instructions::SETNP, params
      end
      def setns(*params)
        gen_with_insn Fisk::Instructions::SETNS, params
      end
      def setnz(*params)
        gen_with_insn Fisk::Instructions::SETNZ, params
      end
      def seto(*params)
        gen_with_insn Fisk::Instructions::SETO, params
      end
      def setp(*params)
        gen_with_insn Fisk::Instructions::SETP, params
      end
      def setpe(*params)
        gen_with_insn Fisk::Instructions::SETPE, params
      end
      def setpo(*params)
        gen_with_insn Fisk::Instructions::SETPO, params
      end
      def sets(*params)
        gen_with_insn Fisk::Instructions::SETS, params
      end
      def setz(*params)
        gen_with_insn Fisk::Instructions::SETZ, params
      end
      def sfence(*params)
        gen_with_insn Fisk::Instructions::SFENCE, params
      end
      def sha1msg1(*params)
        gen_with_insn Fisk::Instructions::SHA1MSG1, params
      end
      def sha1msg2(*params)
        gen_with_insn Fisk::Instructions::SHA1MSG2, params
      end
      def sha1nexte(*params)
        gen_with_insn Fisk::Instructions::SHA1NEXTE, params
      end
      def sha1rnds4(*params)
        gen_with_insn Fisk::Instructions::SHA1RNDS4, params
      end
      def sha256msg1(*params)
        gen_with_insn Fisk::Instructions::SHA256MSG1, params
      end
      def sha256msg2(*params)
        gen_with_insn Fisk::Instructions::SHA256MSG2, params
      end
      def sha256rnds2(*params)
        gen_with_insn Fisk::Instructions::SHA256RNDS2, params
      end
      def shl(*params)
        gen_with_insn Fisk::Instructions::SHL, params
      end
      def shld(*params)
        gen_with_insn Fisk::Instructions::SHLD, params
      end
      def shlx(*params)
        gen_with_insn Fisk::Instructions::SHLX, params
      end
      def shr(*params)
        gen_with_insn Fisk::Instructions::SHR, params
      end
      def shrd(*params)
        gen_with_insn Fisk::Instructions::SHRD, params
      end
      def shrx(*params)
        gen_with_insn Fisk::Instructions::SHRX, params
      end
      def shufpd(*params)
        gen_with_insn Fisk::Instructions::SHUFPD, params
      end
      def shufps(*params)
        gen_with_insn Fisk::Instructions::SHUFPS, params
      end
      def sqrtpd(*params)
        gen_with_insn Fisk::Instructions::SQRTPD, params
      end
      def sqrtps(*params)
        gen_with_insn Fisk::Instructions::SQRTPS, params
      end
      def sqrtsd(*params)
        gen_with_insn Fisk::Instructions::SQRTSD, params
      end
      def sqrtss(*params)
        gen_with_insn Fisk::Instructions::SQRTSS, params
      end
      def stc(*params)
        gen_with_insn Fisk::Instructions::STC, params
      end
      def std(*params)
        gen_with_insn Fisk::Instructions::STD, params
      end
      def stmxcsr(*params)
        gen_with_insn Fisk::Instructions::STMXCSR, params
      end
      def sub(*params)
        gen_with_insn Fisk::Instructions::SUB, params
      end
      def subpd(*params)
        gen_with_insn Fisk::Instructions::SUBPD, params
      end
      def subps(*params)
        gen_with_insn Fisk::Instructions::SUBPS, params
      end
      def subsd(*params)
        gen_with_insn Fisk::Instructions::SUBSD, params
      end
      def subss(*params)
        gen_with_insn Fisk::Instructions::SUBSS, params
      end
      def syscall(*params)
        gen_with_insn Fisk::Instructions::SYSCALL, params
      end
      def t1mskc(*params)
        gen_with_insn Fisk::Instructions::T1MSKC, params
      end
      def test(*params)
        gen_with_insn Fisk::Instructions::TEST, params
      end
      def tzcnt(*params)
        gen_with_insn Fisk::Instructions::TZCNT, params
      end
      def tzmsk(*params)
        gen_with_insn Fisk::Instructions::TZMSK, params
      end
      def ucomisd(*params)
        gen_with_insn Fisk::Instructions::UCOMISD, params
      end
      def ucomiss(*params)
        gen_with_insn Fisk::Instructions::UCOMISS, params
      end
      def ud2(*params)
        gen_with_insn Fisk::Instructions::UD2, params
      end
      def unpckhpd(*params)
        gen_with_insn Fisk::Instructions::UNPCKHPD, params
      end
      def unpckhps(*params)
        gen_with_insn Fisk::Instructions::UNPCKHPS, params
      end
      def unpcklpd(*params)
        gen_with_insn Fisk::Instructions::UNPCKLPD, params
      end
      def unpcklps(*params)
        gen_with_insn Fisk::Instructions::UNPCKLPS, params
      end
      def vaddpd(*params)
        gen_with_insn Fisk::Instructions::VADDPD, params
      end
      def vaddps(*params)
        gen_with_insn Fisk::Instructions::VADDPS, params
      end
      def vaddsd(*params)
        gen_with_insn Fisk::Instructions::VADDSD, params
      end
      def vaddss(*params)
        gen_with_insn Fisk::Instructions::VADDSS, params
      end
      def vaddsubpd(*params)
        gen_with_insn Fisk::Instructions::VADDSUBPD, params
      end
      def vaddsubps(*params)
        gen_with_insn Fisk::Instructions::VADDSUBPS, params
      end
      def vaesdec(*params)
        gen_with_insn Fisk::Instructions::VAESDEC, params
      end
      def vaesdeclast(*params)
        gen_with_insn Fisk::Instructions::VAESDECLAST, params
      end
      def vaesenc(*params)
        gen_with_insn Fisk::Instructions::VAESENC, params
      end
      def vaesenclast(*params)
        gen_with_insn Fisk::Instructions::VAESENCLAST, params
      end
      def vaesimc(*params)
        gen_with_insn Fisk::Instructions::VAESIMC, params
      end
      def vaeskeygenassist(*params)
        gen_with_insn Fisk::Instructions::VAESKEYGENASSIST, params
      end
      def valignd(*params)
        gen_with_insn Fisk::Instructions::VALIGND, params
      end
      def valignq(*params)
        gen_with_insn Fisk::Instructions::VALIGNQ, params
      end
      def vandnpd(*params)
        gen_with_insn Fisk::Instructions::VANDNPD, params
      end
      def vandnps(*params)
        gen_with_insn Fisk::Instructions::VANDNPS, params
      end
      def vandpd(*params)
        gen_with_insn Fisk::Instructions::VANDPD, params
      end
      def vandps(*params)
        gen_with_insn Fisk::Instructions::VANDPS, params
      end
      def vblendmpd(*params)
        gen_with_insn Fisk::Instructions::VBLENDMPD, params
      end
      def vblendmps(*params)
        gen_with_insn Fisk::Instructions::VBLENDMPS, params
      end
      def vblendpd(*params)
        gen_with_insn Fisk::Instructions::VBLENDPD, params
      end
      def vblendps(*params)
        gen_with_insn Fisk::Instructions::VBLENDPS, params
      end
      def vblendvpd(*params)
        gen_with_insn Fisk::Instructions::VBLENDVPD, params
      end
      def vblendvps(*params)
        gen_with_insn Fisk::Instructions::VBLENDVPS, params
      end
      def vbroadcastf128(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTF128, params
      end
      def vbroadcastf32x2(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTF32X2, params
      end
      def vbroadcastf32x4(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTF32X4, params
      end
      def vbroadcastf32x8(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTF32X8, params
      end
      def vbroadcastf64x2(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTF64X2, params
      end
      def vbroadcastf64x4(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTF64X4, params
      end
      def vbroadcasti128(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTI128, params
      end
      def vbroadcasti32x2(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTI32X2, params
      end
      def vbroadcasti32x4(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTI32X4, params
      end
      def vbroadcasti32x8(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTI32X8, params
      end
      def vbroadcasti64x2(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTI64X2, params
      end
      def vbroadcasti64x4(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTI64X4, params
      end
      def vbroadcastsd(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTSD, params
      end
      def vbroadcastss(*params)
        gen_with_insn Fisk::Instructions::VBROADCASTSS, params
      end
      def vcmppd(*params)
        gen_with_insn Fisk::Instructions::VCMPPD, params
      end
      def vcmpps(*params)
        gen_with_insn Fisk::Instructions::VCMPPS, params
      end
      def vcmpsd(*params)
        gen_with_insn Fisk::Instructions::VCMPSD, params
      end
      def vcmpss(*params)
        gen_with_insn Fisk::Instructions::VCMPSS, params
      end
      def vcomisd(*params)
        gen_with_insn Fisk::Instructions::VCOMISD, params
      end
      def vcomiss(*params)
        gen_with_insn Fisk::Instructions::VCOMISS, params
      end
      def vcompresspd(*params)
        gen_with_insn Fisk::Instructions::VCOMPRESSPD, params
      end
      def vcompressps(*params)
        gen_with_insn Fisk::Instructions::VCOMPRESSPS, params
      end
      def vcvtdq2pd(*params)
        gen_with_insn Fisk::Instructions::VCVTDQ2PD, params
      end
      def vcvtdq2ps(*params)
        gen_with_insn Fisk::Instructions::VCVTDQ2PS, params
      end
      def vcvtpd2dq(*params)
        gen_with_insn Fisk::Instructions::VCVTPD2DQ, params
      end
      def vcvtpd2ps(*params)
        gen_with_insn Fisk::Instructions::VCVTPD2PS, params
      end
      def vcvtpd2qq(*params)
        gen_with_insn Fisk::Instructions::VCVTPD2QQ, params
      end
      def vcvtpd2udq(*params)
        gen_with_insn Fisk::Instructions::VCVTPD2UDQ, params
      end
      def vcvtpd2uqq(*params)
        gen_with_insn Fisk::Instructions::VCVTPD2UQQ, params
      end
      def vcvtph2ps(*params)
        gen_with_insn Fisk::Instructions::VCVTPH2PS, params
      end
      def vcvtps2dq(*params)
        gen_with_insn Fisk::Instructions::VCVTPS2DQ, params
      end
      def vcvtps2pd(*params)
        gen_with_insn Fisk::Instructions::VCVTPS2PD, params
      end
      def vcvtps2ph(*params)
        gen_with_insn Fisk::Instructions::VCVTPS2PH, params
      end
      def vcvtps2qq(*params)
        gen_with_insn Fisk::Instructions::VCVTPS2QQ, params
      end
      def vcvtps2udq(*params)
        gen_with_insn Fisk::Instructions::VCVTPS2UDQ, params
      end
      def vcvtps2uqq(*params)
        gen_with_insn Fisk::Instructions::VCVTPS2UQQ, params
      end
      def vcvtqq2pd(*params)
        gen_with_insn Fisk::Instructions::VCVTQQ2PD, params
      end
      def vcvtqq2ps(*params)
        gen_with_insn Fisk::Instructions::VCVTQQ2PS, params
      end
      def vcvtsd2si(*params)
        gen_with_insn Fisk::Instructions::VCVTSD2SI, params
      end
      def vcvtsd2ss(*params)
        gen_with_insn Fisk::Instructions::VCVTSD2SS, params
      end
      def vcvtsd2usi(*params)
        gen_with_insn Fisk::Instructions::VCVTSD2USI, params
      end
      def vcvtsi2sd(*params)
        gen_with_insn Fisk::Instructions::VCVTSI2SD, params
      end
      def vcvtsi2ss(*params)
        gen_with_insn Fisk::Instructions::VCVTSI2SS, params
      end
      def vcvtss2sd(*params)
        gen_with_insn Fisk::Instructions::VCVTSS2SD, params
      end
      def vcvtss2si(*params)
        gen_with_insn Fisk::Instructions::VCVTSS2SI, params
      end
      def vcvtss2usi(*params)
        gen_with_insn Fisk::Instructions::VCVTSS2USI, params
      end
      def vcvttpd2dq(*params)
        gen_with_insn Fisk::Instructions::VCVTTPD2DQ, params
      end
      def vcvttpd2qq(*params)
        gen_with_insn Fisk::Instructions::VCVTTPD2QQ, params
      end
      def vcvttpd2udq(*params)
        gen_with_insn Fisk::Instructions::VCVTTPD2UDQ, params
      end
      def vcvttpd2uqq(*params)
        gen_with_insn Fisk::Instructions::VCVTTPD2UQQ, params
      end
      def vcvttps2dq(*params)
        gen_with_insn Fisk::Instructions::VCVTTPS2DQ, params
      end
      def vcvttps2qq(*params)
        gen_with_insn Fisk::Instructions::VCVTTPS2QQ, params
      end
      def vcvttps2udq(*params)
        gen_with_insn Fisk::Instructions::VCVTTPS2UDQ, params
      end
      def vcvttps2uqq(*params)
        gen_with_insn Fisk::Instructions::VCVTTPS2UQQ, params
      end
      def vcvttsd2si(*params)
        gen_with_insn Fisk::Instructions::VCVTTSD2SI, params
      end
      def vcvttsd2usi(*params)
        gen_with_insn Fisk::Instructions::VCVTTSD2USI, params
      end
      def vcvttss2si(*params)
        gen_with_insn Fisk::Instructions::VCVTTSS2SI, params
      end
      def vcvttss2usi(*params)
        gen_with_insn Fisk::Instructions::VCVTTSS2USI, params
      end
      def vcvtudq2pd(*params)
        gen_with_insn Fisk::Instructions::VCVTUDQ2PD, params
      end
      def vcvtudq2ps(*params)
        gen_with_insn Fisk::Instructions::VCVTUDQ2PS, params
      end
      def vcvtuqq2pd(*params)
        gen_with_insn Fisk::Instructions::VCVTUQQ2PD, params
      end
      def vcvtuqq2ps(*params)
        gen_with_insn Fisk::Instructions::VCVTUQQ2PS, params
      end
      def vcvtusi2sd(*params)
        gen_with_insn Fisk::Instructions::VCVTUSI2SD, params
      end
      def vcvtusi2ss(*params)
        gen_with_insn Fisk::Instructions::VCVTUSI2SS, params
      end
      def vdbpsadbw(*params)
        gen_with_insn Fisk::Instructions::VDBPSADBW, params
      end
      def vdivpd(*params)
        gen_with_insn Fisk::Instructions::VDIVPD, params
      end
      def vdivps(*params)
        gen_with_insn Fisk::Instructions::VDIVPS, params
      end
      def vdivsd(*params)
        gen_with_insn Fisk::Instructions::VDIVSD, params
      end
      def vdivss(*params)
        gen_with_insn Fisk::Instructions::VDIVSS, params
      end
      def vdppd(*params)
        gen_with_insn Fisk::Instructions::VDPPD, params
      end
      def vdpps(*params)
        gen_with_insn Fisk::Instructions::VDPPS, params
      end
      def vexp2pd(*params)
        gen_with_insn Fisk::Instructions::VEXP2PD, params
      end
      def vexp2ps(*params)
        gen_with_insn Fisk::Instructions::VEXP2PS, params
      end
      def vexpandpd(*params)
        gen_with_insn Fisk::Instructions::VEXPANDPD, params
      end
      def vexpandps(*params)
        gen_with_insn Fisk::Instructions::VEXPANDPS, params
      end
      def vextractf128(*params)
        gen_with_insn Fisk::Instructions::VEXTRACTF128, params
      end
      def vextractf32x4(*params)
        gen_with_insn Fisk::Instructions::VEXTRACTF32X4, params
      end
      def vextractf32x8(*params)
        gen_with_insn Fisk::Instructions::VEXTRACTF32X8, params
      end
      def vextractf64x2(*params)
        gen_with_insn Fisk::Instructions::VEXTRACTF64X2, params
      end
      def vextractf64x4(*params)
        gen_with_insn Fisk::Instructions::VEXTRACTF64X4, params
      end
      def vextracti128(*params)
        gen_with_insn Fisk::Instructions::VEXTRACTI128, params
      end
      def vextracti32x4(*params)
        gen_with_insn Fisk::Instructions::VEXTRACTI32X4, params
      end
      def vextracti32x8(*params)
        gen_with_insn Fisk::Instructions::VEXTRACTI32X8, params
      end
      def vextracti64x2(*params)
        gen_with_insn Fisk::Instructions::VEXTRACTI64X2, params
      end
      def vextracti64x4(*params)
        gen_with_insn Fisk::Instructions::VEXTRACTI64X4, params
      end
      def vextractps(*params)
        gen_with_insn Fisk::Instructions::VEXTRACTPS, params
      end
      def vfixupimmpd(*params)
        gen_with_insn Fisk::Instructions::VFIXUPIMMPD, params
      end
      def vfixupimmps(*params)
        gen_with_insn Fisk::Instructions::VFIXUPIMMPS, params
      end
      def vfixupimmsd(*params)
        gen_with_insn Fisk::Instructions::VFIXUPIMMSD, params
      end
      def vfixupimmss(*params)
        gen_with_insn Fisk::Instructions::VFIXUPIMMSS, params
      end
      def vfmadd132pd(*params)
        gen_with_insn Fisk::Instructions::VFMADD132PD, params
      end
      def vfmadd132ps(*params)
        gen_with_insn Fisk::Instructions::VFMADD132PS, params
      end
      def vfmadd132sd(*params)
        gen_with_insn Fisk::Instructions::VFMADD132SD, params
      end
      def vfmadd132ss(*params)
        gen_with_insn Fisk::Instructions::VFMADD132SS, params
      end
      def vfmadd213pd(*params)
        gen_with_insn Fisk::Instructions::VFMADD213PD, params
      end
      def vfmadd213ps(*params)
        gen_with_insn Fisk::Instructions::VFMADD213PS, params
      end
      def vfmadd213sd(*params)
        gen_with_insn Fisk::Instructions::VFMADD213SD, params
      end
      def vfmadd213ss(*params)
        gen_with_insn Fisk::Instructions::VFMADD213SS, params
      end
      def vfmadd231pd(*params)
        gen_with_insn Fisk::Instructions::VFMADD231PD, params
      end
      def vfmadd231ps(*params)
        gen_with_insn Fisk::Instructions::VFMADD231PS, params
      end
      def vfmadd231sd(*params)
        gen_with_insn Fisk::Instructions::VFMADD231SD, params
      end
      def vfmadd231ss(*params)
        gen_with_insn Fisk::Instructions::VFMADD231SS, params
      end
      def vfmaddpd(*params)
        gen_with_insn Fisk::Instructions::VFMADDPD, params
      end
      def vfmaddps(*params)
        gen_with_insn Fisk::Instructions::VFMADDPS, params
      end
      def vfmaddsd(*params)
        gen_with_insn Fisk::Instructions::VFMADDSD, params
      end
      def vfmaddss(*params)
        gen_with_insn Fisk::Instructions::VFMADDSS, params
      end
      def vfmaddsub132pd(*params)
        gen_with_insn Fisk::Instructions::VFMADDSUB132PD, params
      end
      def vfmaddsub132ps(*params)
        gen_with_insn Fisk::Instructions::VFMADDSUB132PS, params
      end
      def vfmaddsub213pd(*params)
        gen_with_insn Fisk::Instructions::VFMADDSUB213PD, params
      end
      def vfmaddsub213ps(*params)
        gen_with_insn Fisk::Instructions::VFMADDSUB213PS, params
      end
      def vfmaddsub231pd(*params)
        gen_with_insn Fisk::Instructions::VFMADDSUB231PD, params
      end
      def vfmaddsub231ps(*params)
        gen_with_insn Fisk::Instructions::VFMADDSUB231PS, params
      end
      def vfmaddsubpd(*params)
        gen_with_insn Fisk::Instructions::VFMADDSUBPD, params
      end
      def vfmaddsubps(*params)
        gen_with_insn Fisk::Instructions::VFMADDSUBPS, params
      end
      def vfmsub132pd(*params)
        gen_with_insn Fisk::Instructions::VFMSUB132PD, params
      end
      def vfmsub132ps(*params)
        gen_with_insn Fisk::Instructions::VFMSUB132PS, params
      end
      def vfmsub132sd(*params)
        gen_with_insn Fisk::Instructions::VFMSUB132SD, params
      end
      def vfmsub132ss(*params)
        gen_with_insn Fisk::Instructions::VFMSUB132SS, params
      end
      def vfmsub213pd(*params)
        gen_with_insn Fisk::Instructions::VFMSUB213PD, params
      end
      def vfmsub213ps(*params)
        gen_with_insn Fisk::Instructions::VFMSUB213PS, params
      end
      def vfmsub213sd(*params)
        gen_with_insn Fisk::Instructions::VFMSUB213SD, params
      end
      def vfmsub213ss(*params)
        gen_with_insn Fisk::Instructions::VFMSUB213SS, params
      end
      def vfmsub231pd(*params)
        gen_with_insn Fisk::Instructions::VFMSUB231PD, params
      end
      def vfmsub231ps(*params)
        gen_with_insn Fisk::Instructions::VFMSUB231PS, params
      end
      def vfmsub231sd(*params)
        gen_with_insn Fisk::Instructions::VFMSUB231SD, params
      end
      def vfmsub231ss(*params)
        gen_with_insn Fisk::Instructions::VFMSUB231SS, params
      end
      def vfmsubadd132pd(*params)
        gen_with_insn Fisk::Instructions::VFMSUBADD132PD, params
      end
      def vfmsubadd132ps(*params)
        gen_with_insn Fisk::Instructions::VFMSUBADD132PS, params
      end
      def vfmsubadd213pd(*params)
        gen_with_insn Fisk::Instructions::VFMSUBADD213PD, params
      end
      def vfmsubadd213ps(*params)
        gen_with_insn Fisk::Instructions::VFMSUBADD213PS, params
      end
      def vfmsubadd231pd(*params)
        gen_with_insn Fisk::Instructions::VFMSUBADD231PD, params
      end
      def vfmsubadd231ps(*params)
        gen_with_insn Fisk::Instructions::VFMSUBADD231PS, params
      end
      def vfmsubaddpd(*params)
        gen_with_insn Fisk::Instructions::VFMSUBADDPD, params
      end
      def vfmsubaddps(*params)
        gen_with_insn Fisk::Instructions::VFMSUBADDPS, params
      end
      def vfmsubpd(*params)
        gen_with_insn Fisk::Instructions::VFMSUBPD, params
      end
      def vfmsubps(*params)
        gen_with_insn Fisk::Instructions::VFMSUBPS, params
      end
      def vfmsubsd(*params)
        gen_with_insn Fisk::Instructions::VFMSUBSD, params
      end
      def vfmsubss(*params)
        gen_with_insn Fisk::Instructions::VFMSUBSS, params
      end
      def vfnmadd132pd(*params)
        gen_with_insn Fisk::Instructions::VFNMADD132PD, params
      end
      def vfnmadd132ps(*params)
        gen_with_insn Fisk::Instructions::VFNMADD132PS, params
      end
      def vfnmadd132sd(*params)
        gen_with_insn Fisk::Instructions::VFNMADD132SD, params
      end
      def vfnmadd132ss(*params)
        gen_with_insn Fisk::Instructions::VFNMADD132SS, params
      end
      def vfnmadd213pd(*params)
        gen_with_insn Fisk::Instructions::VFNMADD213PD, params
      end
      def vfnmadd213ps(*params)
        gen_with_insn Fisk::Instructions::VFNMADD213PS, params
      end
      def vfnmadd213sd(*params)
        gen_with_insn Fisk::Instructions::VFNMADD213SD, params
      end
      def vfnmadd213ss(*params)
        gen_with_insn Fisk::Instructions::VFNMADD213SS, params
      end
      def vfnmadd231pd(*params)
        gen_with_insn Fisk::Instructions::VFNMADD231PD, params
      end
      def vfnmadd231ps(*params)
        gen_with_insn Fisk::Instructions::VFNMADD231PS, params
      end
      def vfnmadd231sd(*params)
        gen_with_insn Fisk::Instructions::VFNMADD231SD, params
      end
      def vfnmadd231ss(*params)
        gen_with_insn Fisk::Instructions::VFNMADD231SS, params
      end
      def vfnmaddpd(*params)
        gen_with_insn Fisk::Instructions::VFNMADDPD, params
      end
      def vfnmaddps(*params)
        gen_with_insn Fisk::Instructions::VFNMADDPS, params
      end
      def vfnmaddsd(*params)
        gen_with_insn Fisk::Instructions::VFNMADDSD, params
      end
      def vfnmaddss(*params)
        gen_with_insn Fisk::Instructions::VFNMADDSS, params
      end
      def vfnmsub132pd(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB132PD, params
      end
      def vfnmsub132ps(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB132PS, params
      end
      def vfnmsub132sd(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB132SD, params
      end
      def vfnmsub132ss(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB132SS, params
      end
      def vfnmsub213pd(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB213PD, params
      end
      def vfnmsub213ps(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB213PS, params
      end
      def vfnmsub213sd(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB213SD, params
      end
      def vfnmsub213ss(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB213SS, params
      end
      def vfnmsub231pd(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB231PD, params
      end
      def vfnmsub231ps(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB231PS, params
      end
      def vfnmsub231sd(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB231SD, params
      end
      def vfnmsub231ss(*params)
        gen_with_insn Fisk::Instructions::VFNMSUB231SS, params
      end
      def vfnmsubpd(*params)
        gen_with_insn Fisk::Instructions::VFNMSUBPD, params
      end
      def vfnmsubps(*params)
        gen_with_insn Fisk::Instructions::VFNMSUBPS, params
      end
      def vfnmsubsd(*params)
        gen_with_insn Fisk::Instructions::VFNMSUBSD, params
      end
      def vfnmsubss(*params)
        gen_with_insn Fisk::Instructions::VFNMSUBSS, params
      end
      def vfpclasspd(*params)
        gen_with_insn Fisk::Instructions::VFPCLASSPD, params
      end
      def vfpclassps(*params)
        gen_with_insn Fisk::Instructions::VFPCLASSPS, params
      end
      def vfpclasssd(*params)
        gen_with_insn Fisk::Instructions::VFPCLASSSD, params
      end
      def vfpclassss(*params)
        gen_with_insn Fisk::Instructions::VFPCLASSSS, params
      end
      def vfrczpd(*params)
        gen_with_insn Fisk::Instructions::VFRCZPD, params
      end
      def vfrczps(*params)
        gen_with_insn Fisk::Instructions::VFRCZPS, params
      end
      def vfrczsd(*params)
        gen_with_insn Fisk::Instructions::VFRCZSD, params
      end
      def vfrczss(*params)
        gen_with_insn Fisk::Instructions::VFRCZSS, params
      end
      def vgatherdpd(*params)
        gen_with_insn Fisk::Instructions::VGATHERDPD, params
      end
      def vgatherdps(*params)
        gen_with_insn Fisk::Instructions::VGATHERDPS, params
      end
      def vgatherpf0dpd(*params)
        gen_with_insn Fisk::Instructions::VGATHERPF0DPD, params
      end
      def vgatherpf0dps(*params)
        gen_with_insn Fisk::Instructions::VGATHERPF0DPS, params
      end
      def vgatherpf0qpd(*params)
        gen_with_insn Fisk::Instructions::VGATHERPF0QPD, params
      end
      def vgatherpf0qps(*params)
        gen_with_insn Fisk::Instructions::VGATHERPF0QPS, params
      end
      def vgatherpf1dpd(*params)
        gen_with_insn Fisk::Instructions::VGATHERPF1DPD, params
      end
      def vgatherpf1dps(*params)
        gen_with_insn Fisk::Instructions::VGATHERPF1DPS, params
      end
      def vgatherpf1qpd(*params)
        gen_with_insn Fisk::Instructions::VGATHERPF1QPD, params
      end
      def vgatherpf1qps(*params)
        gen_with_insn Fisk::Instructions::VGATHERPF1QPS, params
      end
      def vgatherqpd(*params)
        gen_with_insn Fisk::Instructions::VGATHERQPD, params
      end
      def vgatherqps(*params)
        gen_with_insn Fisk::Instructions::VGATHERQPS, params
      end
      def vgetexppd(*params)
        gen_with_insn Fisk::Instructions::VGETEXPPD, params
      end
      def vgetexpps(*params)
        gen_with_insn Fisk::Instructions::VGETEXPPS, params
      end
      def vgetexpsd(*params)
        gen_with_insn Fisk::Instructions::VGETEXPSD, params
      end
      def vgetexpss(*params)
        gen_with_insn Fisk::Instructions::VGETEXPSS, params
      end
      def vgetmantpd(*params)
        gen_with_insn Fisk::Instructions::VGETMANTPD, params
      end
      def vgetmantps(*params)
        gen_with_insn Fisk::Instructions::VGETMANTPS, params
      end
      def vgetmantsd(*params)
        gen_with_insn Fisk::Instructions::VGETMANTSD, params
      end
      def vgetmantss(*params)
        gen_with_insn Fisk::Instructions::VGETMANTSS, params
      end
      def vhaddpd(*params)
        gen_with_insn Fisk::Instructions::VHADDPD, params
      end
      def vhaddps(*params)
        gen_with_insn Fisk::Instructions::VHADDPS, params
      end
      def vhsubpd(*params)
        gen_with_insn Fisk::Instructions::VHSUBPD, params
      end
      def vhsubps(*params)
        gen_with_insn Fisk::Instructions::VHSUBPS, params
      end
      def vinsertf128(*params)
        gen_with_insn Fisk::Instructions::VINSERTF128, params
      end
      def vinsertf32x4(*params)
        gen_with_insn Fisk::Instructions::VINSERTF32X4, params
      end
      def vinsertf32x8(*params)
        gen_with_insn Fisk::Instructions::VINSERTF32X8, params
      end
      def vinsertf64x2(*params)
        gen_with_insn Fisk::Instructions::VINSERTF64X2, params
      end
      def vinsertf64x4(*params)
        gen_with_insn Fisk::Instructions::VINSERTF64X4, params
      end
      def vinserti128(*params)
        gen_with_insn Fisk::Instructions::VINSERTI128, params
      end
      def vinserti32x4(*params)
        gen_with_insn Fisk::Instructions::VINSERTI32X4, params
      end
      def vinserti32x8(*params)
        gen_with_insn Fisk::Instructions::VINSERTI32X8, params
      end
      def vinserti64x2(*params)
        gen_with_insn Fisk::Instructions::VINSERTI64X2, params
      end
      def vinserti64x4(*params)
        gen_with_insn Fisk::Instructions::VINSERTI64X4, params
      end
      def vinsertps(*params)
        gen_with_insn Fisk::Instructions::VINSERTPS, params
      end
      def vlddqu(*params)
        gen_with_insn Fisk::Instructions::VLDDQU, params
      end
      def vldmxcsr(*params)
        gen_with_insn Fisk::Instructions::VLDMXCSR, params
      end
      def vmaskmovdqu(*params)
        gen_with_insn Fisk::Instructions::VMASKMOVDQU, params
      end
      def vmaskmovpd(*params)
        gen_with_insn Fisk::Instructions::VMASKMOVPD, params
      end
      def vmaskmovps(*params)
        gen_with_insn Fisk::Instructions::VMASKMOVPS, params
      end
      def vmaxpd(*params)
        gen_with_insn Fisk::Instructions::VMAXPD, params
      end
      def vmaxps(*params)
        gen_with_insn Fisk::Instructions::VMAXPS, params
      end
      def vmaxsd(*params)
        gen_with_insn Fisk::Instructions::VMAXSD, params
      end
      def vmaxss(*params)
        gen_with_insn Fisk::Instructions::VMAXSS, params
      end
      def vminpd(*params)
        gen_with_insn Fisk::Instructions::VMINPD, params
      end
      def vminps(*params)
        gen_with_insn Fisk::Instructions::VMINPS, params
      end
      def vminsd(*params)
        gen_with_insn Fisk::Instructions::VMINSD, params
      end
      def vminss(*params)
        gen_with_insn Fisk::Instructions::VMINSS, params
      end
      def vmovapd(*params)
        gen_with_insn Fisk::Instructions::VMOVAPD, params
      end
      def vmovaps(*params)
        gen_with_insn Fisk::Instructions::VMOVAPS, params
      end
      def vmovd(*params)
        gen_with_insn Fisk::Instructions::VMOVD, params
      end
      def vmovddup(*params)
        gen_with_insn Fisk::Instructions::VMOVDDUP, params
      end
      def vmovdqa(*params)
        gen_with_insn Fisk::Instructions::VMOVDQA, params
      end
      def vmovdqa32(*params)
        gen_with_insn Fisk::Instructions::VMOVDQA32, params
      end
      def vmovdqa64(*params)
        gen_with_insn Fisk::Instructions::VMOVDQA64, params
      end
      def vmovdqu(*params)
        gen_with_insn Fisk::Instructions::VMOVDQU, params
      end
      def vmovdqu16(*params)
        gen_with_insn Fisk::Instructions::VMOVDQU16, params
      end
      def vmovdqu32(*params)
        gen_with_insn Fisk::Instructions::VMOVDQU32, params
      end
      def vmovdqu64(*params)
        gen_with_insn Fisk::Instructions::VMOVDQU64, params
      end
      def vmovdqu8(*params)
        gen_with_insn Fisk::Instructions::VMOVDQU8, params
      end
      def vmovhlps(*params)
        gen_with_insn Fisk::Instructions::VMOVHLPS, params
      end
      def vmovhpd(*params)
        gen_with_insn Fisk::Instructions::VMOVHPD, params
      end
      def vmovhps(*params)
        gen_with_insn Fisk::Instructions::VMOVHPS, params
      end
      def vmovlhps(*params)
        gen_with_insn Fisk::Instructions::VMOVLHPS, params
      end
      def vmovlpd(*params)
        gen_with_insn Fisk::Instructions::VMOVLPD, params
      end
      def vmovlps(*params)
        gen_with_insn Fisk::Instructions::VMOVLPS, params
      end
      def vmovmskpd(*params)
        gen_with_insn Fisk::Instructions::VMOVMSKPD, params
      end
      def vmovmskps(*params)
        gen_with_insn Fisk::Instructions::VMOVMSKPS, params
      end
      def vmovntdq(*params)
        gen_with_insn Fisk::Instructions::VMOVNTDQ, params
      end
      def vmovntdqa(*params)
        gen_with_insn Fisk::Instructions::VMOVNTDQA, params
      end
      def vmovntpd(*params)
        gen_with_insn Fisk::Instructions::VMOVNTPD, params
      end
      def vmovntps(*params)
        gen_with_insn Fisk::Instructions::VMOVNTPS, params
      end
      def vmovq(*params)
        gen_with_insn Fisk::Instructions::VMOVQ, params
      end
      def vmovsd(*params)
        gen_with_insn Fisk::Instructions::VMOVSD, params
      end
      def vmovshdup(*params)
        gen_with_insn Fisk::Instructions::VMOVSHDUP, params
      end
      def vmovsldup(*params)
        gen_with_insn Fisk::Instructions::VMOVSLDUP, params
      end
      def vmovss(*params)
        gen_with_insn Fisk::Instructions::VMOVSS, params
      end
      def vmovupd(*params)
        gen_with_insn Fisk::Instructions::VMOVUPD, params
      end
      def vmovups(*params)
        gen_with_insn Fisk::Instructions::VMOVUPS, params
      end
      def vmpsadbw(*params)
        gen_with_insn Fisk::Instructions::VMPSADBW, params
      end
      def vmulpd(*params)
        gen_with_insn Fisk::Instructions::VMULPD, params
      end
      def vmulps(*params)
        gen_with_insn Fisk::Instructions::VMULPS, params
      end
      def vmulsd(*params)
        gen_with_insn Fisk::Instructions::VMULSD, params
      end
      def vmulss(*params)
        gen_with_insn Fisk::Instructions::VMULSS, params
      end
      def vorpd(*params)
        gen_with_insn Fisk::Instructions::VORPD, params
      end
      def vorps(*params)
        gen_with_insn Fisk::Instructions::VORPS, params
      end
      def vpabsb(*params)
        gen_with_insn Fisk::Instructions::VPABSB, params
      end
      def vpabsd(*params)
        gen_with_insn Fisk::Instructions::VPABSD, params
      end
      def vpabsq(*params)
        gen_with_insn Fisk::Instructions::VPABSQ, params
      end
      def vpabsw(*params)
        gen_with_insn Fisk::Instructions::VPABSW, params
      end
      def vpackssdw(*params)
        gen_with_insn Fisk::Instructions::VPACKSSDW, params
      end
      def vpacksswb(*params)
        gen_with_insn Fisk::Instructions::VPACKSSWB, params
      end
      def vpackusdw(*params)
        gen_with_insn Fisk::Instructions::VPACKUSDW, params
      end
      def vpackuswb(*params)
        gen_with_insn Fisk::Instructions::VPACKUSWB, params
      end
      def vpaddb(*params)
        gen_with_insn Fisk::Instructions::VPADDB, params
      end
      def vpaddd(*params)
        gen_with_insn Fisk::Instructions::VPADDD, params
      end
      def vpaddq(*params)
        gen_with_insn Fisk::Instructions::VPADDQ, params
      end
      def vpaddsb(*params)
        gen_with_insn Fisk::Instructions::VPADDSB, params
      end
      def vpaddsw(*params)
        gen_with_insn Fisk::Instructions::VPADDSW, params
      end
      def vpaddusb(*params)
        gen_with_insn Fisk::Instructions::VPADDUSB, params
      end
      def vpaddusw(*params)
        gen_with_insn Fisk::Instructions::VPADDUSW, params
      end
      def vpaddw(*params)
        gen_with_insn Fisk::Instructions::VPADDW, params
      end
      def vpalignr(*params)
        gen_with_insn Fisk::Instructions::VPALIGNR, params
      end
      def vpand(*params)
        gen_with_insn Fisk::Instructions::VPAND, params
      end
      def vpandd(*params)
        gen_with_insn Fisk::Instructions::VPANDD, params
      end
      def vpandn(*params)
        gen_with_insn Fisk::Instructions::VPANDN, params
      end
      def vpandnd(*params)
        gen_with_insn Fisk::Instructions::VPANDND, params
      end
      def vpandnq(*params)
        gen_with_insn Fisk::Instructions::VPANDNQ, params
      end
      def vpandq(*params)
        gen_with_insn Fisk::Instructions::VPANDQ, params
      end
      def vpavgb(*params)
        gen_with_insn Fisk::Instructions::VPAVGB, params
      end
      def vpavgw(*params)
        gen_with_insn Fisk::Instructions::VPAVGW, params
      end
      def vpblendd(*params)
        gen_with_insn Fisk::Instructions::VPBLENDD, params
      end
      def vpblendmb(*params)
        gen_with_insn Fisk::Instructions::VPBLENDMB, params
      end
      def vpblendmd(*params)
        gen_with_insn Fisk::Instructions::VPBLENDMD, params
      end
      def vpblendmq(*params)
        gen_with_insn Fisk::Instructions::VPBLENDMQ, params
      end
      def vpblendmw(*params)
        gen_with_insn Fisk::Instructions::VPBLENDMW, params
      end
      def vpblendvb(*params)
        gen_with_insn Fisk::Instructions::VPBLENDVB, params
      end
      def vpblendw(*params)
        gen_with_insn Fisk::Instructions::VPBLENDW, params
      end
      def vpbroadcastb(*params)
        gen_with_insn Fisk::Instructions::VPBROADCASTB, params
      end
      def vpbroadcastd(*params)
        gen_with_insn Fisk::Instructions::VPBROADCASTD, params
      end
      def vpbroadcastmb2q(*params)
        gen_with_insn Fisk::Instructions::VPBROADCASTMB2Q, params
      end
      def vpbroadcastmw2d(*params)
        gen_with_insn Fisk::Instructions::VPBROADCASTMW2D, params
      end
      def vpbroadcastq(*params)
        gen_with_insn Fisk::Instructions::VPBROADCASTQ, params
      end
      def vpbroadcastw(*params)
        gen_with_insn Fisk::Instructions::VPBROADCASTW, params
      end
      def vpclmulqdq(*params)
        gen_with_insn Fisk::Instructions::VPCLMULQDQ, params
      end
      def vpcmov(*params)
        gen_with_insn Fisk::Instructions::VPCMOV, params
      end
      def vpcmpb(*params)
        gen_with_insn Fisk::Instructions::VPCMPB, params
      end
      def vpcmpd(*params)
        gen_with_insn Fisk::Instructions::VPCMPD, params
      end
      def vpcmpeqb(*params)
        gen_with_insn Fisk::Instructions::VPCMPEQB, params
      end
      def vpcmpeqd(*params)
        gen_with_insn Fisk::Instructions::VPCMPEQD, params
      end
      def vpcmpeqq(*params)
        gen_with_insn Fisk::Instructions::VPCMPEQQ, params
      end
      def vpcmpeqw(*params)
        gen_with_insn Fisk::Instructions::VPCMPEQW, params
      end
      def vpcmpestri(*params)
        gen_with_insn Fisk::Instructions::VPCMPESTRI, params
      end
      def vpcmpestrm(*params)
        gen_with_insn Fisk::Instructions::VPCMPESTRM, params
      end
      def vpcmpgtb(*params)
        gen_with_insn Fisk::Instructions::VPCMPGTB, params
      end
      def vpcmpgtd(*params)
        gen_with_insn Fisk::Instructions::VPCMPGTD, params
      end
      def vpcmpgtq(*params)
        gen_with_insn Fisk::Instructions::VPCMPGTQ, params
      end
      def vpcmpgtw(*params)
        gen_with_insn Fisk::Instructions::VPCMPGTW, params
      end
      def vpcmpistri(*params)
        gen_with_insn Fisk::Instructions::VPCMPISTRI, params
      end
      def vpcmpistrm(*params)
        gen_with_insn Fisk::Instructions::VPCMPISTRM, params
      end
      def vpcmpq(*params)
        gen_with_insn Fisk::Instructions::VPCMPQ, params
      end
      def vpcmpub(*params)
        gen_with_insn Fisk::Instructions::VPCMPUB, params
      end
      def vpcmpud(*params)
        gen_with_insn Fisk::Instructions::VPCMPUD, params
      end
      def vpcmpuq(*params)
        gen_with_insn Fisk::Instructions::VPCMPUQ, params
      end
      def vpcmpuw(*params)
        gen_with_insn Fisk::Instructions::VPCMPUW, params
      end
      def vpcmpw(*params)
        gen_with_insn Fisk::Instructions::VPCMPW, params
      end
      def vpcomb(*params)
        gen_with_insn Fisk::Instructions::VPCOMB, params
      end
      def vpcomd(*params)
        gen_with_insn Fisk::Instructions::VPCOMD, params
      end
      def vpcompressd(*params)
        gen_with_insn Fisk::Instructions::VPCOMPRESSD, params
      end
      def vpcompressq(*params)
        gen_with_insn Fisk::Instructions::VPCOMPRESSQ, params
      end
      def vpcomq(*params)
        gen_with_insn Fisk::Instructions::VPCOMQ, params
      end
      def vpcomub(*params)
        gen_with_insn Fisk::Instructions::VPCOMUB, params
      end
      def vpcomud(*params)
        gen_with_insn Fisk::Instructions::VPCOMUD, params
      end
      def vpcomuq(*params)
        gen_with_insn Fisk::Instructions::VPCOMUQ, params
      end
      def vpcomuw(*params)
        gen_with_insn Fisk::Instructions::VPCOMUW, params
      end
      def vpcomw(*params)
        gen_with_insn Fisk::Instructions::VPCOMW, params
      end
      def vpconflictd(*params)
        gen_with_insn Fisk::Instructions::VPCONFLICTD, params
      end
      def vpconflictq(*params)
        gen_with_insn Fisk::Instructions::VPCONFLICTQ, params
      end
      def vperm2f128(*params)
        gen_with_insn Fisk::Instructions::VPERM2F128, params
      end
      def vperm2i128(*params)
        gen_with_insn Fisk::Instructions::VPERM2I128, params
      end
      def vpermb(*params)
        gen_with_insn Fisk::Instructions::VPERMB, params
      end
      def vpermd(*params)
        gen_with_insn Fisk::Instructions::VPERMD, params
      end
      def vpermi2b(*params)
        gen_with_insn Fisk::Instructions::VPERMI2B, params
      end
      def vpermi2d(*params)
        gen_with_insn Fisk::Instructions::VPERMI2D, params
      end
      def vpermi2pd(*params)
        gen_with_insn Fisk::Instructions::VPERMI2PD, params
      end
      def vpermi2ps(*params)
        gen_with_insn Fisk::Instructions::VPERMI2PS, params
      end
      def vpermi2q(*params)
        gen_with_insn Fisk::Instructions::VPERMI2Q, params
      end
      def vpermi2w(*params)
        gen_with_insn Fisk::Instructions::VPERMI2W, params
      end
      def vpermil2pd(*params)
        gen_with_insn Fisk::Instructions::VPERMIL2PD, params
      end
      def vpermil2ps(*params)
        gen_with_insn Fisk::Instructions::VPERMIL2PS, params
      end
      def vpermilpd(*params)
        gen_with_insn Fisk::Instructions::VPERMILPD, params
      end
      def vpermilps(*params)
        gen_with_insn Fisk::Instructions::VPERMILPS, params
      end
      def vpermpd(*params)
        gen_with_insn Fisk::Instructions::VPERMPD, params
      end
      def vpermps(*params)
        gen_with_insn Fisk::Instructions::VPERMPS, params
      end
      def vpermq(*params)
        gen_with_insn Fisk::Instructions::VPERMQ, params
      end
      def vpermt2b(*params)
        gen_with_insn Fisk::Instructions::VPERMT2B, params
      end
      def vpermt2d(*params)
        gen_with_insn Fisk::Instructions::VPERMT2D, params
      end
      def vpermt2pd(*params)
        gen_with_insn Fisk::Instructions::VPERMT2PD, params
      end
      def vpermt2ps(*params)
        gen_with_insn Fisk::Instructions::VPERMT2PS, params
      end
      def vpermt2q(*params)
        gen_with_insn Fisk::Instructions::VPERMT2Q, params
      end
      def vpermt2w(*params)
        gen_with_insn Fisk::Instructions::VPERMT2W, params
      end
      def vpermw(*params)
        gen_with_insn Fisk::Instructions::VPERMW, params
      end
      def vpexpandd(*params)
        gen_with_insn Fisk::Instructions::VPEXPANDD, params
      end
      def vpexpandq(*params)
        gen_with_insn Fisk::Instructions::VPEXPANDQ, params
      end
      def vpextrb(*params)
        gen_with_insn Fisk::Instructions::VPEXTRB, params
      end
      def vpextrd(*params)
        gen_with_insn Fisk::Instructions::VPEXTRD, params
      end
      def vpextrq(*params)
        gen_with_insn Fisk::Instructions::VPEXTRQ, params
      end
      def vpextrw(*params)
        gen_with_insn Fisk::Instructions::VPEXTRW, params
      end
      def vpgatherdd(*params)
        gen_with_insn Fisk::Instructions::VPGATHERDD, params
      end
      def vpgatherdq(*params)
        gen_with_insn Fisk::Instructions::VPGATHERDQ, params
      end
      def vpgatherqd(*params)
        gen_with_insn Fisk::Instructions::VPGATHERQD, params
      end
      def vpgatherqq(*params)
        gen_with_insn Fisk::Instructions::VPGATHERQQ, params
      end
      def vphaddbd(*params)
        gen_with_insn Fisk::Instructions::VPHADDBD, params
      end
      def vphaddbq(*params)
        gen_with_insn Fisk::Instructions::VPHADDBQ, params
      end
      def vphaddbw(*params)
        gen_with_insn Fisk::Instructions::VPHADDBW, params
      end
      def vphaddd(*params)
        gen_with_insn Fisk::Instructions::VPHADDD, params
      end
      def vphadddq(*params)
        gen_with_insn Fisk::Instructions::VPHADDDQ, params
      end
      def vphaddsw(*params)
        gen_with_insn Fisk::Instructions::VPHADDSW, params
      end
      def vphaddubd(*params)
        gen_with_insn Fisk::Instructions::VPHADDUBD, params
      end
      def vphaddubq(*params)
        gen_with_insn Fisk::Instructions::VPHADDUBQ, params
      end
      def vphaddubw(*params)
        gen_with_insn Fisk::Instructions::VPHADDUBW, params
      end
      def vphaddudq(*params)
        gen_with_insn Fisk::Instructions::VPHADDUDQ, params
      end
      def vphadduwd(*params)
        gen_with_insn Fisk::Instructions::VPHADDUWD, params
      end
      def vphadduwq(*params)
        gen_with_insn Fisk::Instructions::VPHADDUWQ, params
      end
      def vphaddw(*params)
        gen_with_insn Fisk::Instructions::VPHADDW, params
      end
      def vphaddwd(*params)
        gen_with_insn Fisk::Instructions::VPHADDWD, params
      end
      def vphaddwq(*params)
        gen_with_insn Fisk::Instructions::VPHADDWQ, params
      end
      def vphminposuw(*params)
        gen_with_insn Fisk::Instructions::VPHMINPOSUW, params
      end
      def vphsubbw(*params)
        gen_with_insn Fisk::Instructions::VPHSUBBW, params
      end
      def vphsubd(*params)
        gen_with_insn Fisk::Instructions::VPHSUBD, params
      end
      def vphsubdq(*params)
        gen_with_insn Fisk::Instructions::VPHSUBDQ, params
      end
      def vphsubsw(*params)
        gen_with_insn Fisk::Instructions::VPHSUBSW, params
      end
      def vphsubw(*params)
        gen_with_insn Fisk::Instructions::VPHSUBW, params
      end
      def vphsubwd(*params)
        gen_with_insn Fisk::Instructions::VPHSUBWD, params
      end
      def vpinsrb(*params)
        gen_with_insn Fisk::Instructions::VPINSRB, params
      end
      def vpinsrd(*params)
        gen_with_insn Fisk::Instructions::VPINSRD, params
      end
      def vpinsrq(*params)
        gen_with_insn Fisk::Instructions::VPINSRQ, params
      end
      def vpinsrw(*params)
        gen_with_insn Fisk::Instructions::VPINSRW, params
      end
      def vplzcntd(*params)
        gen_with_insn Fisk::Instructions::VPLZCNTD, params
      end
      def vplzcntq(*params)
        gen_with_insn Fisk::Instructions::VPLZCNTQ, params
      end
      def vpmacsdd(*params)
        gen_with_insn Fisk::Instructions::VPMACSDD, params
      end
      def vpmacsdqh(*params)
        gen_with_insn Fisk::Instructions::VPMACSDQH, params
      end
      def vpmacsdql(*params)
        gen_with_insn Fisk::Instructions::VPMACSDQL, params
      end
      def vpmacssdd(*params)
        gen_with_insn Fisk::Instructions::VPMACSSDD, params
      end
      def vpmacssdqh(*params)
        gen_with_insn Fisk::Instructions::VPMACSSDQH, params
      end
      def vpmacssdql(*params)
        gen_with_insn Fisk::Instructions::VPMACSSDQL, params
      end
      def vpmacsswd(*params)
        gen_with_insn Fisk::Instructions::VPMACSSWD, params
      end
      def vpmacssww(*params)
        gen_with_insn Fisk::Instructions::VPMACSSWW, params
      end
      def vpmacswd(*params)
        gen_with_insn Fisk::Instructions::VPMACSWD, params
      end
      def vpmacsww(*params)
        gen_with_insn Fisk::Instructions::VPMACSWW, params
      end
      def vpmadcsswd(*params)
        gen_with_insn Fisk::Instructions::VPMADCSSWD, params
      end
      def vpmadcswd(*params)
        gen_with_insn Fisk::Instructions::VPMADCSWD, params
      end
      def vpmadd52huq(*params)
        gen_with_insn Fisk::Instructions::VPMADD52HUQ, params
      end
      def vpmadd52luq(*params)
        gen_with_insn Fisk::Instructions::VPMADD52LUQ, params
      end
      def vpmaddubsw(*params)
        gen_with_insn Fisk::Instructions::VPMADDUBSW, params
      end
      def vpmaddwd(*params)
        gen_with_insn Fisk::Instructions::VPMADDWD, params
      end
      def vpmaskmovd(*params)
        gen_with_insn Fisk::Instructions::VPMASKMOVD, params
      end
      def vpmaskmovq(*params)
        gen_with_insn Fisk::Instructions::VPMASKMOVQ, params
      end
      def vpmaxsb(*params)
        gen_with_insn Fisk::Instructions::VPMAXSB, params
      end
      def vpmaxsd(*params)
        gen_with_insn Fisk::Instructions::VPMAXSD, params
      end
      def vpmaxsq(*params)
        gen_with_insn Fisk::Instructions::VPMAXSQ, params
      end
      def vpmaxsw(*params)
        gen_with_insn Fisk::Instructions::VPMAXSW, params
      end
      def vpmaxub(*params)
        gen_with_insn Fisk::Instructions::VPMAXUB, params
      end
      def vpmaxud(*params)
        gen_with_insn Fisk::Instructions::VPMAXUD, params
      end
      def vpmaxuq(*params)
        gen_with_insn Fisk::Instructions::VPMAXUQ, params
      end
      def vpmaxuw(*params)
        gen_with_insn Fisk::Instructions::VPMAXUW, params
      end
      def vpminsb(*params)
        gen_with_insn Fisk::Instructions::VPMINSB, params
      end
      def vpminsd(*params)
        gen_with_insn Fisk::Instructions::VPMINSD, params
      end
      def vpminsq(*params)
        gen_with_insn Fisk::Instructions::VPMINSQ, params
      end
      def vpminsw(*params)
        gen_with_insn Fisk::Instructions::VPMINSW, params
      end
      def vpminub(*params)
        gen_with_insn Fisk::Instructions::VPMINUB, params
      end
      def vpminud(*params)
        gen_with_insn Fisk::Instructions::VPMINUD, params
      end
      def vpminuq(*params)
        gen_with_insn Fisk::Instructions::VPMINUQ, params
      end
      def vpminuw(*params)
        gen_with_insn Fisk::Instructions::VPMINUW, params
      end
      def vpmovb2m(*params)
        gen_with_insn Fisk::Instructions::VPMOVB2M, params
      end
      def vpmovd2m(*params)
        gen_with_insn Fisk::Instructions::VPMOVD2M, params
      end
      def vpmovdb(*params)
        gen_with_insn Fisk::Instructions::VPMOVDB, params
      end
      def vpmovdw(*params)
        gen_with_insn Fisk::Instructions::VPMOVDW, params
      end
      def vpmovm2b(*params)
        gen_with_insn Fisk::Instructions::VPMOVM2B, params
      end
      def vpmovm2d(*params)
        gen_with_insn Fisk::Instructions::VPMOVM2D, params
      end
      def vpmovm2q(*params)
        gen_with_insn Fisk::Instructions::VPMOVM2Q, params
      end
      def vpmovm2w(*params)
        gen_with_insn Fisk::Instructions::VPMOVM2W, params
      end
      def vpmovmskb(*params)
        gen_with_insn Fisk::Instructions::VPMOVMSKB, params
      end
      def vpmovq2m(*params)
        gen_with_insn Fisk::Instructions::VPMOVQ2M, params
      end
      def vpmovqb(*params)
        gen_with_insn Fisk::Instructions::VPMOVQB, params
      end
      def vpmovqd(*params)
        gen_with_insn Fisk::Instructions::VPMOVQD, params
      end
      def vpmovqw(*params)
        gen_with_insn Fisk::Instructions::VPMOVQW, params
      end
      def vpmovsdb(*params)
        gen_with_insn Fisk::Instructions::VPMOVSDB, params
      end
      def vpmovsdw(*params)
        gen_with_insn Fisk::Instructions::VPMOVSDW, params
      end
      def vpmovsqb(*params)
        gen_with_insn Fisk::Instructions::VPMOVSQB, params
      end
      def vpmovsqd(*params)
        gen_with_insn Fisk::Instructions::VPMOVSQD, params
      end
      def vpmovsqw(*params)
        gen_with_insn Fisk::Instructions::VPMOVSQW, params
      end
      def vpmovswb(*params)
        gen_with_insn Fisk::Instructions::VPMOVSWB, params
      end
      def vpmovsxbd(*params)
        gen_with_insn Fisk::Instructions::VPMOVSXBD, params
      end
      def vpmovsxbq(*params)
        gen_with_insn Fisk::Instructions::VPMOVSXBQ, params
      end
      def vpmovsxbw(*params)
        gen_with_insn Fisk::Instructions::VPMOVSXBW, params
      end
      def vpmovsxdq(*params)
        gen_with_insn Fisk::Instructions::VPMOVSXDQ, params
      end
      def vpmovsxwd(*params)
        gen_with_insn Fisk::Instructions::VPMOVSXWD, params
      end
      def vpmovsxwq(*params)
        gen_with_insn Fisk::Instructions::VPMOVSXWQ, params
      end
      def vpmovusdb(*params)
        gen_with_insn Fisk::Instructions::VPMOVUSDB, params
      end
      def vpmovusdw(*params)
        gen_with_insn Fisk::Instructions::VPMOVUSDW, params
      end
      def vpmovusqb(*params)
        gen_with_insn Fisk::Instructions::VPMOVUSQB, params
      end
      def vpmovusqd(*params)
        gen_with_insn Fisk::Instructions::VPMOVUSQD, params
      end
      def vpmovusqw(*params)
        gen_with_insn Fisk::Instructions::VPMOVUSQW, params
      end
      def vpmovuswb(*params)
        gen_with_insn Fisk::Instructions::VPMOVUSWB, params
      end
      def vpmovw2m(*params)
        gen_with_insn Fisk::Instructions::VPMOVW2M, params
      end
      def vpmovwb(*params)
        gen_with_insn Fisk::Instructions::VPMOVWB, params
      end
      def vpmovzxbd(*params)
        gen_with_insn Fisk::Instructions::VPMOVZXBD, params
      end
      def vpmovzxbq(*params)
        gen_with_insn Fisk::Instructions::VPMOVZXBQ, params
      end
      def vpmovzxbw(*params)
        gen_with_insn Fisk::Instructions::VPMOVZXBW, params
      end
      def vpmovzxdq(*params)
        gen_with_insn Fisk::Instructions::VPMOVZXDQ, params
      end
      def vpmovzxwd(*params)
        gen_with_insn Fisk::Instructions::VPMOVZXWD, params
      end
      def vpmovzxwq(*params)
        gen_with_insn Fisk::Instructions::VPMOVZXWQ, params
      end
      def vpmuldq(*params)
        gen_with_insn Fisk::Instructions::VPMULDQ, params
      end
      def vpmulhrsw(*params)
        gen_with_insn Fisk::Instructions::VPMULHRSW, params
      end
      def vpmulhuw(*params)
        gen_with_insn Fisk::Instructions::VPMULHUW, params
      end
      def vpmulhw(*params)
        gen_with_insn Fisk::Instructions::VPMULHW, params
      end
      def vpmulld(*params)
        gen_with_insn Fisk::Instructions::VPMULLD, params
      end
      def vpmullq(*params)
        gen_with_insn Fisk::Instructions::VPMULLQ, params
      end
      def vpmullw(*params)
        gen_with_insn Fisk::Instructions::VPMULLW, params
      end
      def vpmultishiftqb(*params)
        gen_with_insn Fisk::Instructions::VPMULTISHIFTQB, params
      end
      def vpmuludq(*params)
        gen_with_insn Fisk::Instructions::VPMULUDQ, params
      end
      def vpopcntd(*params)
        gen_with_insn Fisk::Instructions::VPOPCNTD, params
      end
      def vpopcntq(*params)
        gen_with_insn Fisk::Instructions::VPOPCNTQ, params
      end
      def vpor(*params)
        gen_with_insn Fisk::Instructions::VPOR, params
      end
      def vpord(*params)
        gen_with_insn Fisk::Instructions::VPORD, params
      end
      def vporq(*params)
        gen_with_insn Fisk::Instructions::VPORQ, params
      end
      def vpperm(*params)
        gen_with_insn Fisk::Instructions::VPPERM, params
      end
      def vprold(*params)
        gen_with_insn Fisk::Instructions::VPROLD, params
      end
      def vprolq(*params)
        gen_with_insn Fisk::Instructions::VPROLQ, params
      end
      def vprolvd(*params)
        gen_with_insn Fisk::Instructions::VPROLVD, params
      end
      def vprolvq(*params)
        gen_with_insn Fisk::Instructions::VPROLVQ, params
      end
      def vprord(*params)
        gen_with_insn Fisk::Instructions::VPRORD, params
      end
      def vprorq(*params)
        gen_with_insn Fisk::Instructions::VPRORQ, params
      end
      def vprorvd(*params)
        gen_with_insn Fisk::Instructions::VPRORVD, params
      end
      def vprorvq(*params)
        gen_with_insn Fisk::Instructions::VPRORVQ, params
      end
      def vprotb(*params)
        gen_with_insn Fisk::Instructions::VPROTB, params
      end
      def vprotd(*params)
        gen_with_insn Fisk::Instructions::VPROTD, params
      end
      def vprotq(*params)
        gen_with_insn Fisk::Instructions::VPROTQ, params
      end
      def vprotw(*params)
        gen_with_insn Fisk::Instructions::VPROTW, params
      end
      def vpsadbw(*params)
        gen_with_insn Fisk::Instructions::VPSADBW, params
      end
      def vpscatterdd(*params)
        gen_with_insn Fisk::Instructions::VPSCATTERDD, params
      end
      def vpscatterdq(*params)
        gen_with_insn Fisk::Instructions::VPSCATTERDQ, params
      end
      def vpscatterqd(*params)
        gen_with_insn Fisk::Instructions::VPSCATTERQD, params
      end
      def vpscatterqq(*params)
        gen_with_insn Fisk::Instructions::VPSCATTERQQ, params
      end
      def vpshab(*params)
        gen_with_insn Fisk::Instructions::VPSHAB, params
      end
      def vpshad(*params)
        gen_with_insn Fisk::Instructions::VPSHAD, params
      end
      def vpshaq(*params)
        gen_with_insn Fisk::Instructions::VPSHAQ, params
      end
      def vpshaw(*params)
        gen_with_insn Fisk::Instructions::VPSHAW, params
      end
      def vpshlb(*params)
        gen_with_insn Fisk::Instructions::VPSHLB, params
      end
      def vpshld(*params)
        gen_with_insn Fisk::Instructions::VPSHLD, params
      end
      def vpshlq(*params)
        gen_with_insn Fisk::Instructions::VPSHLQ, params
      end
      def vpshlw(*params)
        gen_with_insn Fisk::Instructions::VPSHLW, params
      end
      def vpshufb(*params)
        gen_with_insn Fisk::Instructions::VPSHUFB, params
      end
      def vpshufd(*params)
        gen_with_insn Fisk::Instructions::VPSHUFD, params
      end
      def vpshufhw(*params)
        gen_with_insn Fisk::Instructions::VPSHUFHW, params
      end
      def vpshuflw(*params)
        gen_with_insn Fisk::Instructions::VPSHUFLW, params
      end
      def vpsignb(*params)
        gen_with_insn Fisk::Instructions::VPSIGNB, params
      end
      def vpsignd(*params)
        gen_with_insn Fisk::Instructions::VPSIGND, params
      end
      def vpsignw(*params)
        gen_with_insn Fisk::Instructions::VPSIGNW, params
      end
      def vpslld(*params)
        gen_with_insn Fisk::Instructions::VPSLLD, params
      end
      def vpslldq(*params)
        gen_with_insn Fisk::Instructions::VPSLLDQ, params
      end
      def vpsllq(*params)
        gen_with_insn Fisk::Instructions::VPSLLQ, params
      end
      def vpsllvd(*params)
        gen_with_insn Fisk::Instructions::VPSLLVD, params
      end
      def vpsllvq(*params)
        gen_with_insn Fisk::Instructions::VPSLLVQ, params
      end
      def vpsllvw(*params)
        gen_with_insn Fisk::Instructions::VPSLLVW, params
      end
      def vpsllw(*params)
        gen_with_insn Fisk::Instructions::VPSLLW, params
      end
      def vpsrad(*params)
        gen_with_insn Fisk::Instructions::VPSRAD, params
      end
      def vpsraq(*params)
        gen_with_insn Fisk::Instructions::VPSRAQ, params
      end
      def vpsravd(*params)
        gen_with_insn Fisk::Instructions::VPSRAVD, params
      end
      def vpsravq(*params)
        gen_with_insn Fisk::Instructions::VPSRAVQ, params
      end
      def vpsravw(*params)
        gen_with_insn Fisk::Instructions::VPSRAVW, params
      end
      def vpsraw(*params)
        gen_with_insn Fisk::Instructions::VPSRAW, params
      end
      def vpsrld(*params)
        gen_with_insn Fisk::Instructions::VPSRLD, params
      end
      def vpsrldq(*params)
        gen_with_insn Fisk::Instructions::VPSRLDQ, params
      end
      def vpsrlq(*params)
        gen_with_insn Fisk::Instructions::VPSRLQ, params
      end
      def vpsrlvd(*params)
        gen_with_insn Fisk::Instructions::VPSRLVD, params
      end
      def vpsrlvq(*params)
        gen_with_insn Fisk::Instructions::VPSRLVQ, params
      end
      def vpsrlvw(*params)
        gen_with_insn Fisk::Instructions::VPSRLVW, params
      end
      def vpsrlw(*params)
        gen_with_insn Fisk::Instructions::VPSRLW, params
      end
      def vpsubb(*params)
        gen_with_insn Fisk::Instructions::VPSUBB, params
      end
      def vpsubd(*params)
        gen_with_insn Fisk::Instructions::VPSUBD, params
      end
      def vpsubq(*params)
        gen_with_insn Fisk::Instructions::VPSUBQ, params
      end
      def vpsubsb(*params)
        gen_with_insn Fisk::Instructions::VPSUBSB, params
      end
      def vpsubsw(*params)
        gen_with_insn Fisk::Instructions::VPSUBSW, params
      end
      def vpsubusb(*params)
        gen_with_insn Fisk::Instructions::VPSUBUSB, params
      end
      def vpsubusw(*params)
        gen_with_insn Fisk::Instructions::VPSUBUSW, params
      end
      def vpsubw(*params)
        gen_with_insn Fisk::Instructions::VPSUBW, params
      end
      def vpternlogd(*params)
        gen_with_insn Fisk::Instructions::VPTERNLOGD, params
      end
      def vpternlogq(*params)
        gen_with_insn Fisk::Instructions::VPTERNLOGQ, params
      end
      def vptest(*params)
        gen_with_insn Fisk::Instructions::VPTEST, params
      end
      def vptestmb(*params)
        gen_with_insn Fisk::Instructions::VPTESTMB, params
      end
      def vptestmd(*params)
        gen_with_insn Fisk::Instructions::VPTESTMD, params
      end
      def vptestmq(*params)
        gen_with_insn Fisk::Instructions::VPTESTMQ, params
      end
      def vptestmw(*params)
        gen_with_insn Fisk::Instructions::VPTESTMW, params
      end
      def vptestnmb(*params)
        gen_with_insn Fisk::Instructions::VPTESTNMB, params
      end
      def vptestnmd(*params)
        gen_with_insn Fisk::Instructions::VPTESTNMD, params
      end
      def vptestnmq(*params)
        gen_with_insn Fisk::Instructions::VPTESTNMQ, params
      end
      def vptestnmw(*params)
        gen_with_insn Fisk::Instructions::VPTESTNMW, params
      end
      def vpunpckhbw(*params)
        gen_with_insn Fisk::Instructions::VPUNPCKHBW, params
      end
      def vpunpckhdq(*params)
        gen_with_insn Fisk::Instructions::VPUNPCKHDQ, params
      end
      def vpunpckhqdq(*params)
        gen_with_insn Fisk::Instructions::VPUNPCKHQDQ, params
      end
      def vpunpckhwd(*params)
        gen_with_insn Fisk::Instructions::VPUNPCKHWD, params
      end
      def vpunpcklbw(*params)
        gen_with_insn Fisk::Instructions::VPUNPCKLBW, params
      end
      def vpunpckldq(*params)
        gen_with_insn Fisk::Instructions::VPUNPCKLDQ, params
      end
      def vpunpcklqdq(*params)
        gen_with_insn Fisk::Instructions::VPUNPCKLQDQ, params
      end
      def vpunpcklwd(*params)
        gen_with_insn Fisk::Instructions::VPUNPCKLWD, params
      end
      def vpxor(*params)
        gen_with_insn Fisk::Instructions::VPXOR, params
      end
      def vpxord(*params)
        gen_with_insn Fisk::Instructions::VPXORD, params
      end
      def vpxorq(*params)
        gen_with_insn Fisk::Instructions::VPXORQ, params
      end
      def vrangepd(*params)
        gen_with_insn Fisk::Instructions::VRANGEPD, params
      end
      def vrangeps(*params)
        gen_with_insn Fisk::Instructions::VRANGEPS, params
      end
      def vrangesd(*params)
        gen_with_insn Fisk::Instructions::VRANGESD, params
      end
      def vrangess(*params)
        gen_with_insn Fisk::Instructions::VRANGESS, params
      end
      def vrcp14pd(*params)
        gen_with_insn Fisk::Instructions::VRCP14PD, params
      end
      def vrcp14ps(*params)
        gen_with_insn Fisk::Instructions::VRCP14PS, params
      end
      def vrcp14sd(*params)
        gen_with_insn Fisk::Instructions::VRCP14SD, params
      end
      def vrcp14ss(*params)
        gen_with_insn Fisk::Instructions::VRCP14SS, params
      end
      def vrcp28pd(*params)
        gen_with_insn Fisk::Instructions::VRCP28PD, params
      end
      def vrcp28ps(*params)
        gen_with_insn Fisk::Instructions::VRCP28PS, params
      end
      def vrcp28sd(*params)
        gen_with_insn Fisk::Instructions::VRCP28SD, params
      end
      def vrcp28ss(*params)
        gen_with_insn Fisk::Instructions::VRCP28SS, params
      end
      def vrcpps(*params)
        gen_with_insn Fisk::Instructions::VRCPPS, params
      end
      def vrcpss(*params)
        gen_with_insn Fisk::Instructions::VRCPSS, params
      end
      def vreducepd(*params)
        gen_with_insn Fisk::Instructions::VREDUCEPD, params
      end
      def vreduceps(*params)
        gen_with_insn Fisk::Instructions::VREDUCEPS, params
      end
      def vreducesd(*params)
        gen_with_insn Fisk::Instructions::VREDUCESD, params
      end
      def vreducess(*params)
        gen_with_insn Fisk::Instructions::VREDUCESS, params
      end
      def vrndscalepd(*params)
        gen_with_insn Fisk::Instructions::VRNDSCALEPD, params
      end
      def vrndscaleps(*params)
        gen_with_insn Fisk::Instructions::VRNDSCALEPS, params
      end
      def vrndscalesd(*params)
        gen_with_insn Fisk::Instructions::VRNDSCALESD, params
      end
      def vrndscaless(*params)
        gen_with_insn Fisk::Instructions::VRNDSCALESS, params
      end
      def vroundpd(*params)
        gen_with_insn Fisk::Instructions::VROUNDPD, params
      end
      def vroundps(*params)
        gen_with_insn Fisk::Instructions::VROUNDPS, params
      end
      def vroundsd(*params)
        gen_with_insn Fisk::Instructions::VROUNDSD, params
      end
      def vroundss(*params)
        gen_with_insn Fisk::Instructions::VROUNDSS, params
      end
      def vrsqrt14pd(*params)
        gen_with_insn Fisk::Instructions::VRSQRT14PD, params
      end
      def vrsqrt14ps(*params)
        gen_with_insn Fisk::Instructions::VRSQRT14PS, params
      end
      def vrsqrt14sd(*params)
        gen_with_insn Fisk::Instructions::VRSQRT14SD, params
      end
      def vrsqrt14ss(*params)
        gen_with_insn Fisk::Instructions::VRSQRT14SS, params
      end
      def vrsqrt28pd(*params)
        gen_with_insn Fisk::Instructions::VRSQRT28PD, params
      end
      def vrsqrt28ps(*params)
        gen_with_insn Fisk::Instructions::VRSQRT28PS, params
      end
      def vrsqrt28sd(*params)
        gen_with_insn Fisk::Instructions::VRSQRT28SD, params
      end
      def vrsqrt28ss(*params)
        gen_with_insn Fisk::Instructions::VRSQRT28SS, params
      end
      def vrsqrtps(*params)
        gen_with_insn Fisk::Instructions::VRSQRTPS, params
      end
      def vrsqrtss(*params)
        gen_with_insn Fisk::Instructions::VRSQRTSS, params
      end
      def vscalefpd(*params)
        gen_with_insn Fisk::Instructions::VSCALEFPD, params
      end
      def vscalefps(*params)
        gen_with_insn Fisk::Instructions::VSCALEFPS, params
      end
      def vscalefsd(*params)
        gen_with_insn Fisk::Instructions::VSCALEFSD, params
      end
      def vscalefss(*params)
        gen_with_insn Fisk::Instructions::VSCALEFSS, params
      end
      def vscatterdpd(*params)
        gen_with_insn Fisk::Instructions::VSCATTERDPD, params
      end
      def vscatterdps(*params)
        gen_with_insn Fisk::Instructions::VSCATTERDPS, params
      end
      def vscatterpf0dpd(*params)
        gen_with_insn Fisk::Instructions::VSCATTERPF0DPD, params
      end
      def vscatterpf0dps(*params)
        gen_with_insn Fisk::Instructions::VSCATTERPF0DPS, params
      end
      def vscatterpf0qpd(*params)
        gen_with_insn Fisk::Instructions::VSCATTERPF0QPD, params
      end
      def vscatterpf0qps(*params)
        gen_with_insn Fisk::Instructions::VSCATTERPF0QPS, params
      end
      def vscatterpf1dpd(*params)
        gen_with_insn Fisk::Instructions::VSCATTERPF1DPD, params
      end
      def vscatterpf1dps(*params)
        gen_with_insn Fisk::Instructions::VSCATTERPF1DPS, params
      end
      def vscatterpf1qpd(*params)
        gen_with_insn Fisk::Instructions::VSCATTERPF1QPD, params
      end
      def vscatterpf1qps(*params)
        gen_with_insn Fisk::Instructions::VSCATTERPF1QPS, params
      end
      def vscatterqpd(*params)
        gen_with_insn Fisk::Instructions::VSCATTERQPD, params
      end
      def vscatterqps(*params)
        gen_with_insn Fisk::Instructions::VSCATTERQPS, params
      end
      def vshuff32x4(*params)
        gen_with_insn Fisk::Instructions::VSHUFF32X4, params
      end
      def vshuff64x2(*params)
        gen_with_insn Fisk::Instructions::VSHUFF64X2, params
      end
      def vshufi32x4(*params)
        gen_with_insn Fisk::Instructions::VSHUFI32X4, params
      end
      def vshufi64x2(*params)
        gen_with_insn Fisk::Instructions::VSHUFI64X2, params
      end
      def vshufpd(*params)
        gen_with_insn Fisk::Instructions::VSHUFPD, params
      end
      def vshufps(*params)
        gen_with_insn Fisk::Instructions::VSHUFPS, params
      end
      def vsqrtpd(*params)
        gen_with_insn Fisk::Instructions::VSQRTPD, params
      end
      def vsqrtps(*params)
        gen_with_insn Fisk::Instructions::VSQRTPS, params
      end
      def vsqrtsd(*params)
        gen_with_insn Fisk::Instructions::VSQRTSD, params
      end
      def vsqrtss(*params)
        gen_with_insn Fisk::Instructions::VSQRTSS, params
      end
      def vstmxcsr(*params)
        gen_with_insn Fisk::Instructions::VSTMXCSR, params
      end
      def vsubpd(*params)
        gen_with_insn Fisk::Instructions::VSUBPD, params
      end
      def vsubps(*params)
        gen_with_insn Fisk::Instructions::VSUBPS, params
      end
      def vsubsd(*params)
        gen_with_insn Fisk::Instructions::VSUBSD, params
      end
      def vsubss(*params)
        gen_with_insn Fisk::Instructions::VSUBSS, params
      end
      def vtestpd(*params)
        gen_with_insn Fisk::Instructions::VTESTPD, params
      end
      def vtestps(*params)
        gen_with_insn Fisk::Instructions::VTESTPS, params
      end
      def vucomisd(*params)
        gen_with_insn Fisk::Instructions::VUCOMISD, params
      end
      def vucomiss(*params)
        gen_with_insn Fisk::Instructions::VUCOMISS, params
      end
      def vunpckhpd(*params)
        gen_with_insn Fisk::Instructions::VUNPCKHPD, params
      end
      def vunpckhps(*params)
        gen_with_insn Fisk::Instructions::VUNPCKHPS, params
      end
      def vunpcklpd(*params)
        gen_with_insn Fisk::Instructions::VUNPCKLPD, params
      end
      def vunpcklps(*params)
        gen_with_insn Fisk::Instructions::VUNPCKLPS, params
      end
      def vxorpd(*params)
        gen_with_insn Fisk::Instructions::VXORPD, params
      end
      def vxorps(*params)
        gen_with_insn Fisk::Instructions::VXORPS, params
      end
      def vzeroall(*params)
        gen_with_insn Fisk::Instructions::VZEROALL, params
      end
      def vzeroupper(*params)
        gen_with_insn Fisk::Instructions::VZEROUPPER, params
      end
      def xadd(*params)
        gen_with_insn Fisk::Instructions::XADD, params
      end
      def xchg(*params)
        gen_with_insn Fisk::Instructions::XCHG, params
      end
      def xgetbv(*params)
        gen_with_insn Fisk::Instructions::XGETBV, params
      end
      def xlatb(*params)
        gen_with_insn Fisk::Instructions::XLATB, params
      end
      def xor(*params)
        gen_with_insn Fisk::Instructions::XOR, params
      end
      def xorpd(*params)
        gen_with_insn Fisk::Instructions::XORPD, params
      end
      def xorps(*params)
        gen_with_insn Fisk::Instructions::XORPS, params
      end
    end
  end
end
