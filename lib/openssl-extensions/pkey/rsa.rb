require 'openssl-extensions'
require 'openssl-extensions/pkey'

##
# Extends OpenSSL::PKey::RSA with helper methods.
#
module OpenSSLExtensions::PKey::RSA
  def strength
    n.num_bits
  end
end

OpenSSL::PKey::RSA.send(:include, OpenSSLExtensions::PKey::RSA)
