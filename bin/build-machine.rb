require "nokogiri"
require "stringio"
require "erb"

doc = Nokogiri::XML(File.binread(ARGV[0]))
license = File.readlines(ARGV[1])
erb = ERB.new File.read("bin/machine.rb.erb"), trim_mode: "-"
puts erb.result(binding)
