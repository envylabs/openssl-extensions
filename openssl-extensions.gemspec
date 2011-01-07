# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'openssl-extensions/version'

extra_rdoc_files = ['CHANGELOG.md', 'LICENSE', 'README.md']

Gem::Specification.new do |s|
  s.name = 'openssl-extensions'
  s.version = OpenSSLExtensions::Version
  s.platform = Gem::Platform::RUBY
  s.authors = ['Nathaniel Bibler']
  s.email = ['nate@envylabs.com']
  s.homepage = 'http://github.com/envylabs/openssl-extensions'
  s.summary = 'Helper methods and extensions for OpenSSL to make the interface more intuitive.'
  s.description = 'This library patches OpenSSL to add helper methods and extensions to OpenSSL objects with the intention of making the interface more intuitive.'
  s.required_rubygems_version = '>= 1.3.6'

  s.add_development_dependency 'rspec', '~> 2.4.0'
  s.add_development_dependency 'fuubar', '~> 0.0.1'

  s.files = Dir.glob('lib/**/*') + extra_rdoc_files
  s.test_files = Dir.glob('spec/**/*')
  s.require_path = 'lib'
end
