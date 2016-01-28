# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gracenote/version'

Gem::Specification.new do |spec|
  spec.name          = "gracenote-rb"
  spec.version       = Gracenote::VERSION
  spec.authors       = ["Tomoya Hirano"]
  spec.email         = ["hiranotomoya@gmail.com"]

  spec.summary       = %q{Gracenote Client for modern Ruby}
  spec.description   = %q{Gracenote Client for modern Ruby}
  spec.homepage      = "https://github.com/tomoya55/gracenote-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "ox"
  spec.add_dependency "multi_xml"
  spec.add_dependency "gyoku"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "minitest-power_assert"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
end
