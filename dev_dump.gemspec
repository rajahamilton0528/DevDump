# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dev_dump/version'

Gem::Specification.new do |spec|
  spec.name          = "dev_dump"
  spec.version       = DevDump::VERSION
  spec.authors       = ["Andy Atkinson"]
  spec.email         = ["andyatkinson@gmail.com"]
  spec.summary       = %q{Rake tasks to work with a remote database.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
