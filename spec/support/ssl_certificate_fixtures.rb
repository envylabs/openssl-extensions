module SslCertificateFixtures

  ##
  # Returns an OpenSSL::X509::Certificate without explicit extensions.
  #
  def ssl_certificates(name)
    name = name.to_s.downcase.gsub(/[^\w\.]/, '-')
    @_ssl_certificates ||= {}
    return @_ssl_certificates[name].dup if @_ssl_certificates.has_key?(name)

    certificate_path = File.expand_path("../../fixtures/certificates/#{name}.pem", __FILE__)
    @_ssl_certificates[name] = File.exist?(certificate_path) ?
      OpenSSL::X509::Certificate.new(File.read(certificate_path)) :
      nil
  end

  ##
  # Returns an OpenSSL::X509::Certificate explicitly extended with OpenSSLExtensions::X509::Certificate.
  #
  def extended_ssl_certificates(name)
    ssl_certificates(name).extend(OpenSSLExtensions::X509::Certificate)
  end

end

RSpec.configure do |config|
  config.include SslCertificateFixtures
end
