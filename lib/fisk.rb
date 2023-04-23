# frozen_string_literal: true

require "stringio"
require "set"

require "fisk/instructions"
require "fisk/basic_block"
require "fisk/errors"
require "fisk/optimizer"
require "fisk/version"

class Fisk
  # Performance functionality options.
  #
  PERFORMANCE_CHECK = :check
  PERFORMANCE_OPTIMIZE = :optimize

  module OperandPredicates
    def unresolved?;        false; end
    def register?;          false; end
    def temp_register?;     false; end
    def extended_register?; false; end
    def memory?;            false; end
    def rip?;               false; end
    def immediate?;         false; end
    def absolute_location?; false; end
  end

  module OperandSize
    def compute_size type
      return 128 if type.start_with?('xmm')

      bits = type[/^r(\d+)$/, 1]&.to_i

      if bits.nil?
        raise ArgumentError, "Unexpected register type (#{type}); 'r<bits>' expected"
      elsif bits % 8 != 0
        raise ArgumentError, "Unexpected register size (#{bits}); multiple of 8 expected"
      else
        bits
      end
    end
  end

  class Operand
    include OperandPredicates

    def works? op
      self.type == op.type
    end

    def rex_value
      value >> 3
    end

    def op_value
      value
    end
  end

  class ValueOperand < Operand
    attr_reader :value
    alias :type :value

    def initialize value
      @value = value
    end
  end

  module Registers
    class Register < Operand
      include OperandSize

      attr_reader :name, :type, :value, :size

      def initialize name, type, value
        @name = name
        @type = type
        @value = value
        @size = compute_size(type)
      end

      def works? op
        type = op.type
        type == self.name || type == self.type
      end

      def op_value
        value
      end

      def extended_register?
        @value > 7 || EXTENDED_R8.include?(self)
      end

      def register?; true; end

      def integer?; false; end

      def to_i; @value; end

      def to_register
        self
      end
    end

    class Rip < Operand
      attr_accessor :displacement

      def initialize displacement
        @displacement = displacement
      end

      def works? op
        type = op.type
        type == "m64" || type == "m"
      end

      def unresolved?
        @displacement.is_a?(Fisk::UnknownLabel)
      end

      def memory?; true; end
      def rip?; true; end

      def rex_value
        0x0
      end

      def op_value
        0x0
      end
    end

    class Temp < Operand
      include OperandSize

      attr_reader :name, :type, :size
      attr_accessor :register, :start_point, :end_point

      def initialize name, type
        @name        = name
        @type        = type
        @register    = nil
        @start_point = nil
        @end_point   = nil
        @size        = compute_size(type)
      end

      def temp_register?; true; end
      def register?; true; end

      def op_value
        reg.op_value
      end

      def extended_register?
        reg.extended_register?
      end

      def rex_value
        reg.rex_value
      end

      def value
        reg.value
      end

      def to_register
        self
      end

      def reg
        unless @register
          raise Errors::UnassignedRegister, "Temporary register #{name} hasn't been assigned a real register"
        end

        @register
      end
    end

    AL  = Register.new "al", "r8", 0
    CL  = Register.new "cl", "r8", 1
    DL  = Register.new "dl", "r8", 2
    BL  = Register.new "bl", "r8", 3

    SPL = Register.new "spl", "r8", 4
    BPL = Register.new "bpl", "r8", 5
    SIL = Register.new "sil", "r8", 6
    DIL = Register.new "dil", "r8", 7
    EXTENDED_R8 = [SPL, BPL, SIL, DIL]

    AH = Register.new "ah", "r8", 4
    CH = Register.new "ch", "r8", 5
    DH = Register.new "dh", "r8", 6
    BH = Register.new "bh", "r8", 7

    AX = Register.new "ax", "r16", 0
    CX = Register.new "cx", "r16", 1
    DX = Register.new "dx", "r16", 2
    BX = Register.new "bx", "r16", 3
    SP = Register.new "sp", "r16", 4
    BP = Register.new "bp", "r16", 5
    SI = Register.new "si", "r16", 6
    DI = Register.new "di", "r16", 7

    EAX = Register.new "eax", "r32", 0
    ECX = Register.new "ecx", "r32", 1
    EDX = Register.new "edx", "r32", 2
    EBX = Register.new "ebx", "r32", 3
    ESP = Register.new "esp", "r32", 4
    EBP = Register.new "ebp", "r32", 5
    ESI = Register.new "esi", "r32", 6
    EDI = Register.new "edi", "r32", 7

    RAX = Register.new "rax", "r64", 0
    RCX = Register.new "rcx", "r64", 1
    RDX = Register.new "rdx", "r64", 2
    RBX = Register.new "rbx", "r64", 3
    RSP = Register.new "rsp", "r64", 4
    RBP = Register.new "rbp", "r64", 5
    RSI = Register.new "rsi", "r64", 6
    RDI = Register.new "rdi", "r64", 7
    8.times do |i|
      i += 8
      const_set "R#{i}", Register.new("r#{i}", "r64", i)
      const_set "R#{i}D", Register.new("r#{i}d", "r32", i)
      const_set "R#{i}W", Register.new("r#{i}w", "r16", i)
      const_set "R#{i}B", Register.new("r#{i}b", "r8", i)
    end

    # List of *caller* saved registers for the C calling convention
    CALLER_SAVED = [ RDI, RSI, RDX, RCX, R8, R9, R10, R11 ]

    # List of *callee* saved registers for the C calling convention
    CALLEE_SAVED = [ RBX, RSP, RBP, R12, R13, R14, R15 ]
  end

  class Memory < Operand
    attr_reader :register, :displacement

    def initialize register, displacement
      @register     = register
      @displacement = displacement
    end

    def extended_register?
      @register.extended_register?
    end

    def value
      @register.value
    end

    def + displacement
      self.class.new(register, self.displacement + displacement)
    end

    def memory?; true; end

    def rex_value
      @register.rex_value
    end
  end

  [8, 16, 32, 64].each do |size|
    class_eval <<~eostr, __FILE__, __LINE__ + 1
      class M#{size} < Memory
        def type
          "m#{size}"
        end

        def size; #{size}; end
      end

      def m#{size} val, displacement = 0; M#{size}.new(val, displacement); end
    eostr
  end

  class M < Memory
    def type
      "m"
    end
  end

  def rip displacement = 0
    Registers::Rip.new(displacement)
  end

  def m x, displacement = 0
    M.new x, displacement
  end

  class ImmediateOperand < ValueOperand
    def immediate?; true; end

    def works? insn_op
      insn_op.immediate? && size <= insn_op.size
    end
  end

  # Define all immediate value methods of different sizes
  [8, 16, 32, 64].each do |size|
    class_eval <<~eostr, __FILE__, __LINE__ + 1
      class Imm#{size} < ImmediateOperand
        def type
          "imm#{size}"
        end

        def size; #{size}; end
      end

      def imm#{size} val; Imm#{size}.new(val.to_i); end
    eostr
  end

  class Relative < ValueOperand; end

  class Rel8 < Relative
    def type
      "rel8"
    end
  end

  class Rel32 < Relative
    def type
      "rel32"
    end
  end

  class MOffs64 < ValueOperand
    def type
      "moffs64"
    end
  end

  class Lit < ValueOperand
    def type
      value.to_s
    end
  end

  class UnknownLabel < Operand
    attr_reader :name

    def initialize name
      @name = name
    end

    def works? op
      type = op.type
      type == "rel32"
    end

    def unresolved?; true; end
  end

  module InstructionPredicates
    def retry?;              false; end
    def label?;              false; end
    def jump?;               false; end
    def has_temp_registers?; false; end
    def comment?;            false; end
    def lazy?;               false; end
  end

  class Label < Struct.new(:name)
    include InstructionPredicates

    def label?; true; end
  end

  class Comment < Struct.new(:message)
    include InstructionPredicates

    def comment?; true; end
  end

  class Instruction
    include InstructionPredicates

    attr_reader :insn, :form, :operands

    def initialize insn, form, operands
      @insn     = insn
      @form     = form
      @operands = operands
    end

    def has_temp_registers?
      @operands.any?(&:temp_register?)
    end

    def temp_registers
      @operands.find_all(&:temp_register?)
    end

    def encodings
      @form.encodings
    end

    def encode buffer, labels
      encoding = @form.encodings.first
      encoding.encode buffer, @operands
    end
  end

  class UnresolvedRIPInstruction
    include InstructionPredicates

    def initialize insn, form, operands
      @insn      = insn
      @form      = form
      @operands  = operands
      @retry     = false
      @saved_pos = 0
    end

    def retry?; true; end

    def encode buffer, labels
      # Use dummy values for any unresolvable operands
      operands = @operands.map do |op|
        if op.rip? && op.unresolved?
          # Try resolving the operands
          if labels.key?(op.displacement.name)
            Registers::Rip.new labels[op.displacement.name] - @saved_pos
          else
            Registers::Rip.new 0x0CAFE
          end
        else
          op
        end
      end

      @form.encodings.first.encode buffer, operands
      @saved_pos = buffer.pos
    end
  end

  class AbsoluteJumpInstruction
    include InstructionPredicates

    def initialize insn, form, operand
      @insn       = insn
      @form       = form
      @operand    = operand
      @must_retry = false
    end

    def jump?
      true
    end

    def target
      @operand.name
    end

    def encode buffer, labels
      form              = find_form "rel32"
      encoding          = form.encodings.first
      operand_klass     = Rel32

      pos = buffer.pos
      rel_jump = 0xCAFE
      2.times do
        buffer.seek pos, IO::SEEK_SET
        encoding.encode buffer, [operand_klass.new(rel_jump)]
        rel_jump = @operand.value - buffer.address
      end
    end

    private

    def find_form form_type
      @insn.forms.find { |form| form.operands.first.type == form_type }
    end
  end

  class UnresolvedJumpInstruction
    include InstructionPredicates

    def initialize insn, form, operand
      @insn       = insn
      @form       = form
      @operand    = operand
      @must_retry = false
    end

    def jump?
      true
    end

    def target
      @operand.name
    end

    def retry?
      true
    end

    def encode buffer, labels
      # Estimate by using a rel32 offset
      form              = find_form "rel32"
      encoding          = form.encodings.first
      operand_klass     = Rel32

      if labels.key? target
        unless @must_retry
          estimated_offset = labels[target] - (buffer.pos + 6) # 6 seems like a good length

          if estimated_offset >= -128 && estimated_offset <= 127
            # fits in a rel8
            operand_klass     = Rel8
            form              = find_form "rel8"
            encoding          = form.encodings.first
          end
        end

        # We don't know what the size of the jump will be, so just write
        # it out with some dummy data and keep track of the buffer position.
        # Calculate the real jump offset, then rewind and patch the jump with
        # the right location. 😩
        pos = buffer.pos
        encoding.encode buffer, [operand_klass.new(0xFE)]
        jump_len = -(buffer.pos - labels[target])
        buffer.seek pos, IO::SEEK_SET
        encoding.encode buffer, [operand_klass.new(jump_len)]
      else
        if @must_retry
          # We retried once, but the label wasn't defined
          raise Errors::MissingLabel, "Label `#{target}` was used, but not defined"
        end
        @must_retry = true
        encoding.encode buffer, [operand_klass.new(0x0CAFE)]
      end
    end

    private

    def find_form form_type
      @insn.forms.find { |form| form.operands.first.type == form_type }
    end
  end

  # params:
  #   :performance: Enable performance-related functionalities:
  #                 - :check: raise a SuboptimalPerformance error on write if suboptimal
  #                   instructions are detected.
  #                 - :optimize: optimize the generated code.
  #
  def initialize performance: nil
    @instructions = []
    @labels = {}
    @performance_mode = performance
    @performance_warnings = []
    @optimizer = Optimizer.new
    # A set of temp registers recorded as we see them (not at allocation time)
    @temp_registers = Set.new
    yield self if block_given?
  end

  # Mark a temporary register as "done being used" at this point in the
  # instructions.  Using the register after passing the register to this
  # method results in undefined behavior.
  def release_register reg
    if reg.end_point
      raise Errors::AlreadyReleasedError, "register #{reg.name} already released at #{reg.end_point}"
    end

    reg.end_point = (@instructions.length - 1)
  end

  # Releases all registers that haven't already been released
  def release_all_registers
    @temp_registers.each do |reg|
      next if reg.end_point
      release_register reg
    end
  end

  # Return a list of basic blocks for the instructions
  def basic_blocks
    cfg.blocks
  end

  # Return a cfg for these instructions.  The CFG includes connected basic
  # blocks as well as any temporary registers
  def cfg
    CFG.build @instructions
  end

  # Create a label to be used with jump instructions.  For example:
  #
  #   fisk.jmp(fisk.label(:foo))
  #   fisk.int(lit(3))
  #   fisk.put_label(:foo)
  #
  def label name
    UnknownLabel.new(name)
  end

  Lazy = Struct.new(:block) do # :nodoc:
    include InstructionPredicates

    def lazy?; true; end

    def encode buffer, labels
      block.call buffer.pos
    end
  end

  # Record a block that will be called during instruction encoding.  The block
  # will be yielded the current position of the buffer.
  #
  # For example:
  #
  #   patch_position = nil
  #
  #   fisk.nop
  #   fisk.lazy { |pos| patch_location = pos }
  #   fisk.jmp(fisk.label(:foo))
  #   fisk.lazy { |_|
  #     fisk.mov(fisk.r8, fisk.imm64(patch_location))
  #   }
  #   fisk.write_to(buf)
  #
  # The first lazy block will be yielded the position of the buffer immediately
  # after encoding the `nop` instruction and before encoding the `jmp`
  # instruction.  The second lazy block will be yielded to after the `jmp`
  # instruction has been encoded.  This gives you a chance to write the buffer
  # position from certain points in to your assembly
  def lazy &block
    @instructions << Lazy.new(block)
    self
  end

  # Insert a label named +name+ at the current position in the instructions.
  def put_label name
    if @labels.key? name
      raise Errors::LabelAlreadyDefined, "Label `#{name}` is already defined"
    end
    @labels[name] = nil
    @instructions << Label.new(name)
    self
  end
  alias :make_label :put_label

  # Insert a comment at the current position in the instructions.
  def comment message
    @instructions << Comment.new(message)
    self
  end

  # Allocate and return a new register.  These registers will be replaced with
  # real registers when `assign_registers` is called.
  def register name = "temp"
    Registers::Temp.new name, "r64"
  end

  # Allocate a register and yield it to the block.  The register will be
  # automatically released after the block is finished.
  def with_register name = "temp"
    reg = register(name)
    yield reg
    release_register reg
  end

  # Assign registers to any temporary registers.  Only registers in +list+
  # will be used when selecting register assignments
  def assign_registers list, local: false
    temp_registers = @temp_registers

    # This mutates the temp registers, setting their end_point based on
    # the CFG
    self.cfg unless local

    temp_registers.each do |reg|
      unless reg.end_point
        raise Errors::UnreleasedRegisterError, "Register #{reg.name} hasn't been released"
      end
    end

    temp_registers = temp_registers.sort_by(&:start_point)

    active         = []
    free_registers = list.reverse
    register_count = list.length

    temp_registers.each do |temp_reg|
      # expire old intervals
      active, dead = active.sort_by(&:end_point).partition do |j|
        j.end_point >= temp_reg.start_point
      end

      # Add unused registers back to the free register list
      dead.each { |tr| free_registers << tr.register }

      if active.length == register_count
        raise NotImplementedError, "Register spilled"
      end

      temp_reg.register = free_registers.pop
      active << temp_reg
    end
  end

  Registers.constants.grep(/^[A-Z0-9]*$/).each do |const|
    val = Registers.const_get const
    define_method(const.downcase) { val }
  end

  include Fisk::Instructions::DSLMethods

  def moffs64 val
    MOffs64.new val
  end

  # Create a signed immediate value of the right width
  def imm val
    val = val.to_i

    if val >= -0x7F - 1 && val <= 0x7F
      imm8 val
    elsif val >=  -0x7FFF - 1 && val <= 0x7FFF
      imm16 val
    elsif val >=  -0x7FFFFFFF - 1 && val <= 0x7FFFFFFF
      imm32 val
    elsif val >=  -0x7FFFFFFFFFFFFFFF - 1 && val <= 0x7FFFFFFFFFFFFFFF
      imm64 val
    else
      raise ArgumentError, "#{val} is larger than a 64 bit int"
    end
  end

  # Create an unsigned immediate value of the right width
  def uimm val
    val = val.to_i

    if val < 0
      raise ArgumentError, "#{val} is negative"
    elsif val <= 0xFF
      imm8 val
    elsif val <= 0xFFFF
      imm16 val
    elsif val <= 0xFFFFFFFF
      imm32 val
    elsif val <= 0xFFFFFFFFFFFFFFFF
      imm64 val
    else
      raise ArgumentError, "#{val} is too large for a 64 bit int"
    end
  end

  def rel8 val
    Rel8.new val
  end

  def rel32 val
    Rel32.new val
  end

  class AbsoluteLocation < Rel32
    def absolute_location?;  true; end
  end

  # Creates an "absolute" location.  Use this for JUMP instructions where you
  # know the absolute location but want a relative location calculated later.
  #
  # For example:
  #
  #   fisk.jmp fisk.absolute(0xCAFE)
  #
  # The emitted JMP instruction will use a calculated relative address (this is
  # because x64 doesn't have a jump to absolute position).
  def absolute val
    AbsoluteLocation.new val
  end

  def lit val
    Lit.new val
  end

  # Instance eval's a given block and writes encoded instructions to +buf+.
  # For example:
  #
  #   fisk = Fisk.new
  #   fisk.asm do
  #     mov r9, imm64(32)
  #   end
  #
  def asm buf = StringIO.new(''.b), metadata: {}, &block
    instance_eval(&block)
    write_to buf, metadata: metadata
    buf
  end

  # Encodes all instructions and returns a binary string with the encoded
  # instructions.
  def to_binary(metadata: {})
    io = StringIO.new ''.b
    write_to io, metadata: metadata
    io.string
  end

  RetryRequest = Struct.new(:insn, :io_seek_pos)

  # Encode all instructions and write them to +buffer+.  +buffer+ should be an
  # IO object.
  # If the performance check is enabled, a runtime error is raised if suboptimal
  # instructions are found.
  def write_to buffer, metadata: {}
    labels = {}
    comments = {}
    unresolved = []
    instructions = @instructions.dup
    backup = @instructions.dup
    @instructions.clear

    while insn = instructions.shift
      if insn.label?
        labels[insn.name] = buffer.pos
      elsif insn.comment?
        comments.update({buffer.pos => insn.message}) { |_, *lines| lines.join($/) }
      elsif insn.lazy?
        write_instruction insn, buffer, labels
        instructions.unshift(*@instructions)
        @instructions.clear
      else
        if insn.retry?
          retry_req = RetryRequest.new(insn, buffer.pos)
          unresolved << retry_req
        end

        write_instruction insn, buffer, labels
      end
    end

    metadata[:comments] = comments
    @instructions = backup

    if !unresolved.empty?
      pos = buffer.pos
      unresolved.each do |req|
        insn = req.insn
        buffer.seek req.io_seek_pos, IO::SEEK_SET
        write_instruction insn, buffer, labels
      end
      buffer.seek pos, IO::SEEK_SET
    end

    if !@performance_warnings.empty?
      raise Errors::SuboptimalPerformance.new(@performance_warnings)
    end

    buffer
  end

  # If the performance check is enabled, warnings are added to @performance_warnings.
  def gen_with_insn insns, params
    forms = insns.forms.find_all do |insn|
      if insn.operands.length == params.length
        params.zip(insn.operands).all? { |want_op, have_op|
          want_op.works?(have_op)
        }
      else
        false
      end
    end

    if forms.length == 0
      valid_forms = insns.forms.map { |form|
        "    #{insns.name} #{form.operands.map(&:type).join(", ")}"
      }.join "\n"
      msg = <<~eostr
      Couldn't find instruction #{insns.name} #{params.map(&:type).join(", ")}
      Valid forms:
      #{valid_forms}
      eostr
      raise Errors::InvalidInstructionError, msg
    end

    form = forms.first

    insn = nil

    params.each do |param|
      if param.unresolved?
        if insns.name =~ /^J/ # I hope all jump instructions start with J!
          insn = UnresolvedJumpInstruction.new(insns, form, params.first)
        else
          # If it's not a jump instruction, assume unresolved RIP relative 😬
          insn = UnresolvedRIPInstruction.new(insns, form, params)
        end
      end

      if param.absolute_location? && insns.name =~ /^(?:J|CALL)/
        insn = AbsoluteJumpInstruction.new(insns, form, params.first)
      end

      if param.temp_register?
        if param.end_point
          raise Errors::UseAfterInvalidationError, "Register #{param.name} used after release"
        end
        @temp_registers << param

        param.start_point ||= @instructions.length
      end
    end

    if insn.nil?
      insn = Instruction.new(insns, form, params)

      case @performance_mode
      when PERFORMANCE_CHECK
        warning = insns.check_performance(params)
        @performance_warnings << warning if warning
      when PERFORMANCE_OPTIMIZE
        insn = @optimizer.optimize(insn)
      end
    end

    @instructions << insn if insn

    self
  end

  private

  def write_instruction insn, buffer, labels
    insn.encode buffer, labels
  end
end
