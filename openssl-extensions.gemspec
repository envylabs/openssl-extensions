# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openssl-extensions/version'

Gem::Specification.new do |spec|
  spec.name        = 'openssl-extensions'
  spec.version     = OpenSSLExtensions::Version
  spec.authors     = ["Envy Labs"]
  spec.email       = [""]
  spec.summary     = 'Helper methods and extensions for OpenSSL to make the interface more intuitive.'
  spec.description = 'This library patches OpenSSL to add helper methods and extensions to OpenSSL objects with the intention of making the interface more intuitive.'
  spec.homepage    = 'http://github.com/envylabs/openssl-extensions'
  spec.license     = 'MIT'

  spec.add_development_dependency 'rspec', '~> 2.4'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
