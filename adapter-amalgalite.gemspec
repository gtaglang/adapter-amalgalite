# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "adapter/amalgalite/version"

Gem::Specification.new do |s|
  s.name        = "adapter-amalgalite"
  s.version     = Adapter::Amalgalite::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Guy Taglang"]
  s.email       = ["gtaglang@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Adapter for amalgalite}
  s.description = %q{Adapter for amalgalite}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'adapter', '~> 0.5.1'
  s.add_dependency 'amalgalite', '~> 1.1.2'
end
