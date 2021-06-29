require "nokogiri"
require "stringio"
require "erb"

def parse_rex v
  if v
    case v
    when /^(\d+)$/
      v
    when /^#(\d+)$/
      "(operands[#{$1.to_i}].value >> 3)"
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
      "operands[#{$1.to_i}].value"
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
erb = ERB.new File.read("bin/machine.rb.erb"), trim_mode: "-"
puts erb.result(binding)
