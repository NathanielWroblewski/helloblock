# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'helloblock/version'

Gem::Specification.new do |spec|
  spec.name          = "helloblock"
  spec.version       = HelloBlock::VERSION
  spec.authors       = ["Nathaniel Wroblewski"]
  spec.email         = ["nathanielwroblewski@gmail.com"]
  spec.description   = %q{Fluent Ruby wrapper for the helloblock.io API}
  spec.summary       = %q{Fluent Ruby wrapper for the helloblock.io API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler',        '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec',          '~> 2.14'
  spec.add_development_dependency 'webmock',        '~> 1.17'
  spec.add_development_dependency 'vcr',            '~> 2.8'
  spec.add_development_dependency 'guard-rspec',    '~> 4.2'

  spec.add_runtime_dependency 'multi_json',         '~> 1.9'
  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'yajl-ruby',          '~> 1.2'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.9'
  spec.add_runtime_dependency 'rash',               '~> 0.4'
end
