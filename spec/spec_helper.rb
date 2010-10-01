# encoding: utf-8
lib = File.expand_path('../../lib', __FILE__)
$:.unshift lib unless $:.include?(lib)

begin
  require 'openssl'
rescue LoadError
  $stderr.puts "OpenSSLExtensions requires Ruby to be compiled with OpenSSL support"
  exit(1)
end

require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require :default, :test

require 'openssl-extensions/all'

Dir.glob(File.join(File.dirname(__FILE__), 'support/**/*.rb')).each do |f|
  require f
end
