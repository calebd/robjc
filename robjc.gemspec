# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'robjc/version'

Gem::Specification.new do |spec|
  spec.name          = "robjc"
  spec.version       = Resource::VERSION
  spec.authors       = ["Caleb Davenport"]
  spec.email         = ["calebmdavenport@gmail.com"]
  spec.summary       = %q{A summary.}
  spec.description   = %q{A description.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # spec.add_runtime_dependency "listen"
  spec.add_runtime_dependency "xcodeproj"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
