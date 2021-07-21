$: << File.expand_path("lib")

require "fisk/version"

Gem::Specification.new do |s|
  s.name        = "fisk"
  s.version     = Fisk::VERSION
  s.summary     = "Write assembly in Ruby!"
  s.description = "Tired of writing Ruby in Ruby? Now you can write assembly in Ruby!"
  s.authors     = ["Aaron Patterson"]
  s.email       = "tenderlove@ruby-lang.org"
  s.files       = `git ls-files -z`.split("\x0")
  s.test_files  = s.files.grep(%r{^test/})
  s.homepage    = "https://github.com/tenderlove/fisk"
  s.license     = "Apache-2.0"

  s.add_development_dependency 'minitest', '~> 5.14'
  s.add_development_dependency 'crabstone', '~> 4.0'
  s.add_development_dependency 'rake', '~> 13.0'
end
