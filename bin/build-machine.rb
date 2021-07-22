require "nokogiri"
require "stringio"
require "erb"

def modrm_method operands
  op_types = operands.map { |x| x["type"] }
  case op_types
  in [/^m\d*$/, /^r\d+$/]
    "add_modrm_mem_reg"
  in [/^r\d+$/, /^m\d*$/]
    "add_modrm_reg_mem"
  in [/^r\d+$/, /^r\d+$/]
    "add_modrm_reg_reg"
  else
    "add_modrm"
  end
end

def parse_rex v
  if v
    case v
    when /^(\d+)$/
      v
    when /^#(\d+)$/
      "operands[#{$1.to_i}].rex_value"
    else
      raise NotImplementedError, v
    end
  else
    0
  end
end

def parse_operand_value v
  if v
    case v
    when /^(\d+)$/
      v
    when /^#(\d+)$/
      "operands[#{$1.to_i}].op_value"
    else
      raise NotImplementedError, v
    end
  else
    0
  end
end

doc = Nokogiri::XML(File.binread(ARGV[0]))
unique_operands = doc.css("Operand").map { |node|
  %w{ type input output }.map { |x| node[x] }
}.uniq
license = File.readlines(ARGV[1])
insns_dir = ARGV[2]

instruction_template = ERB.new File.read("bin/instruction.rb.erb"), trim_mode: "-"

doc.root.children.each do |instruction|
  next unless instruction.name == "Instruction"
  name = instruction["name"]
  insn_source = instruction_template.result(binding)
  file_name = File.join(insns_dir, "#{name.downcase}.rb")
  File.binwrite file_name, insn_source
end

instructions_rb = ERB.new File.read("bin/instructions.rb.erb"), trim_mode: "-"
puts instructions_rb.result(binding)
