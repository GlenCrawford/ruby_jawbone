# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_jawbone/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_jawbone"
  spec.version       = RubyJawbone::VERSION
  spec.authors       = ["Glen Crawford"]
  spec.email         = ["glencraw4d@gmail.com"]
  spec.summary       = %q{Reads data files for Jawbone users and provides information about activity, sleep, etc.}
  spec.description   = ""
  spec.homepage      = "https://github.com/GlenCrawford/ruby_jawbone"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0.beta1"
end
