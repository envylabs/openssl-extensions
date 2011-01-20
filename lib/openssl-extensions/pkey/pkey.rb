require 'openssl-extensions'
require 'openssl-extensions/pkey'

##
# Extends OpenSSL::PKey::PKey and its submodules with helper methods.
#
module OpenSSLExtensions::PKey::PKey
  ##
  # Equality is tested by comparing the instances' +hash+.
  #
  def ==(other)
    other.kind_of?(OpenSSL::PKey::PKey) &&
      self.hash == other.hash
  end
  alias_method :eql?, :==

  ##
  # Override the default Object#hash to identify uniqueness of the key.
  # This uses a hash of the PEM.
  #
  def hash
    to_pem.hash
  end
end

OpenSSL::PKey::PKey.send(:include, OpenSSLExtensions::PKey::PKey)
