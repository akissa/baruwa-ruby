# -*- encoding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4
# baruwa: Ruby bindings for the Baruwa REST API
# Copyright (C) 2015-2016 Andrew Colin Kissa <andrew@topdog.za.net>
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
$:.push File.expand_path("../lib", __FILE__)
require "baruwa/version"

Gem::Specification.new do |s|
  s.name        = "baruwa"
  s.version     = Baruwa::VERSION
  s.authors     = ["Andrew Colin Kissa"]
  s.email       = ["andrew@topdog.za.net"]
  s.homepage    = "https://github.com/akissa/baruwa-ruby"
  s.summary     = %q{Ruby bindings for the Baruwa REST API}
  s.description = %q{Gem to access the Baruwa REST API in ruby and ruby on rails applications.}
  s.license     = "MPL-2.0"

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
