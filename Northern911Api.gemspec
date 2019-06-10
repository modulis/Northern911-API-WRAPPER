# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Northern911Api/version'

Gem::Specification.new do |spec|
  spec.name          = "Northern911Api"
  spec.version       = Northern911Api::VERSION
  spec.authors       = ["CHABANON Julien"]
  spec.email         = ["julien.chabanon@modulis.ca"]

  spec.summary       = %q{A simple API wrapper for Northern911 SOAP API}
  spec.description   = %q{This API wrapper is meant to provide a rails friendly configurable api wrapper to access Northern911's SOAP based API using Savon gem.}
  spec.homepage      = "http://github.com/modulis/Northern911-API-WRAPPER"
  spec.license       = "MIT"

  spec.name          = "northern911-client"
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "savon", "~> 2.x"
end
