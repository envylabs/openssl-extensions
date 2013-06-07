require 'openssl-extensions'
require 'openssl-extensions/ssl'
require 'openssl-extensions/x509/certificate_chain'

module OpenSSLExtensions::SSL::SSLSocket
  def self.included(base)
    base.send(:alias_method,
              :peer_cert_chain_without_openssl_extension,
              :peer_cert_chain)
    base.send(:alias_method,
              :peer_cert_chain,
              :peer_cert_chain_with_openssl_extension)
  end

  ##
  # Rather than returning the default, unsorted Array of
  # OpenSSL::X509::Certificate instances, this will filter that
  # Array through the OpenSSLExtensions::X509::CertificateChain.
  #
  def peer_cert_chain_with_openssl_extension
    OpenSSLExtensions::X509::CertificateChain.
      new(peer_cert, peer_cert_chain_without_openssl_extension)
  end
end

OpenSSL::SSL::SSLSocket.send(:include, OpenSSLExtensions::SSL::SSLSocket)
