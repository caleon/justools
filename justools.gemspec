$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "justools/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "Justools"
  s.version     = Justools::VERSION
  s.authors     = ["caleon"]
  s.email       = ["caleon@gmail.com"]
  s.homepage    = "http://github.com/caleon/justools"
  s.summary     = "Core extensions with lots of handy methods"
  s.description = "Core extensions with lots of handy methods"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
end
