$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "core_utilities/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "core_utilities"
  s.version     = CoreUtilities::VERSION
  s.authors     = ["caleon"]
  s.email       = ["caleon@gmail.com"]
  s.homepage    = "http://github.com/caleon/core_utilities"
  s.summary     = "Core extensions with lots of handy methods"
  s.description = "Core extensions with lots of handy methods"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  #s.add_dependency "rails", "~> 3.1.1"
  s.add_dependency 'activesupport', '~> 3.1.1'

  # s.add_development_dependency "sqlite3"
end
