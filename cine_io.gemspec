# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cine_io/version'

Gem::Specification.new do |spec|
  spec.name          = "cine_io"
  spec.version       = CineIo::VERSION
  spec.authors       = ["cine.io"]
  spec.email         = ["support@cine.io"]
  spec.description   = %q{cine.io is an api driven platform for creating and publish live streams. The provides cine.io functionality using your given public and secret keys.}
  spec.summary       = %q{The official cine.io ruby gem}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
end
