module CertificateRequestFixtures

  ##
  # Returns an OpenSSL::X509::Request without explicit extensions.
  #
  def certificate_request(name)
    name = name.to_s.downcase.gsub(/[^\w\.]/, '-')
    @_certificate_requests ||= {}
    return @_certificate_requests[name].dup if @_certificate_requests.has_key?(name)

    request_path = File.expand_path("../../fixtures/certificate_requests/#{name}.csr", __FILE__)
    @_certificate_requests[name] = File.exist?(request_path) ?
      OpenSSL::X509::Request.new(File.read(request_path)) :
      nil
  end

  ##
  # Returns an OpenSSL::X509::Request explicitly extended with OpenSSLExtensions::X509::Request.
  #
  def extended_certificate_request(name)
    certificate_request(name).extend(OpenSSLExtensions::X509::Request)
  end

end

RSpec.configure do |config|
  config.include CertificateRequestFixtures
end

