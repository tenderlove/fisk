Gem::Specification.new do |s|
  s.name        = "fisk"
  s.version     = "2.0.0"
  s.summary     = "Write assembly in Ruby!"
  s.description = "Tired of writing Ruby in Ruby? Now you can write assembly in Ruby!"
  s.authors     = ["Aaron Patterson"]
  s.email       = "tenderlove@ruby-lang.org"
  s.files       = `git ls-files -z`.split("\x0")
  s.test_files  = s.files.grep(%r{^test/})
  s.homepage    = "https://github.com/tenderlove/fisk"
  s.license     = "Apache-2.0"
end
