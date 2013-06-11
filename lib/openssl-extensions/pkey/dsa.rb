require 'openssl-extensions'
require 'openssl-extensions/pkey'

##
# Extends OpenSSL::PKey::RSA with helper methods.
#
module OpenSSLExtensions::PKey::DSA
  def strength
    p.num_bits
  end
end

OpenSSL::PKey::DSA.send(:include, OpenSSLExtensions::PKey::DSA)
