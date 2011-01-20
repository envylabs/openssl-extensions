require 'openssl-extensions'
require 'openssl-extensions/pkey'

##
# Extends OpenSSL::PKey::PKey and its submodules with helper methods.
#
module OpenSSLExtensions::PKey::PKey
  def ==(other)
    other.kind_of?(OpenSSL::PKey::PKey) &&
      self.hash == other.hash
  end
  alias_method :eql?, :==

  def hash
    to_pem.hash
  end
end

OpenSSL::PKey::PKey.send(:include, OpenSSLExtensions::PKey::PKey)
