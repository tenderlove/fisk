require "nokogiri"
require "stringio"
require "erb"

doc = Nokogiri::XML(File.binread(ARGV[0]))
unique_operands = doc.css("Operand").map { |node|
  %w{ type input output }.map { |x| node[x] }
}.uniq
license = File.readlines(ARGV[1])
erb = ERB.new File.read("bin/machine.rb.erb"), trim_mode: "-"
puts erb.result(binding)
