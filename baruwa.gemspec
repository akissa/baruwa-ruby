# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "baruwa/version"

Gem::Specification.new do |s|
  s.name        = "baruwa"
  s.version     = Baruwa::VERSION
  s.authors     = ["Andrew Colin Kissa"]
  s.email       = ["andrew@topdog.za.net"]
  s.homepage    = "https://github.com/akissa/baruwa-ruby"
  s.summary     = %q{Ruby bindings for Baruwa REST API}
  s.description = %q{Gem to access Baruwa REST API in ruby and ruby on rails applications.}
  s.license = "MPL-2.0"

  s.rubyforge_project = "baruwa"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.5"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency 'webmock'
end
