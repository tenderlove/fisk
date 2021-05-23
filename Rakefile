require "rake/testtask"
require "rake/clean"

ENV["MT_NO_PLUGINS"] = "1"

XML_FILE     = "tmp/Opcodes/opcodes/x86_64.xml"
LICENCE_FILE = "tmp/Opcodes/license.rst"
LIB_FILE     = "lib/fisk/machine/generated.rb"

file XML_FILE do
  Dir.mkdir 'tmp' unless File.directory?("tmp")
  cd "tmp"
  sh "git clone https://github.com/Maratyszcza/Opcodes.git"
end

file LIB_FILE => XML_FILE do
  ruby "bin/build-machine.rb #{XML_FILE} #{LICENCE_FILE} > #{LIB_FILE}"
end

CLEAN.include LIB_FILE

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
  t.warning = true
end

task :test => LIB_FILE
