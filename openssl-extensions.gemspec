lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'openssl-extensions/version'

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

  s.add_development_dependency 'rspec', '>= 2.0.0.beta.19'

  s.files = Dir.glob('lib/**/*')
  s.require_path = 'lib'
end
