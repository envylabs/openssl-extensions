require 'openssl-extensions'

module OpenSSLExtensions
  module BN
    ##
    # OpenSSL deals with serials in HEX format.
    # This gives you the ability to get this hex serial if you need to work with 
    # certificate information directly with OpenSSL
    def to_hex
      to_s(16).upcase
    end
  end
end

OpenSSL::BN.send(:include, OpenSSLExtensions::BN)
