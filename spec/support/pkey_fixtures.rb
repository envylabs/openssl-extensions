module PKeyFixtures
  ##
  # Returns an OpenSSL::X509::Certificate without explicit extensions.
  #
  def pkeys(name)
    name = name.to_s.downcase.gsub(/[^\w\.]/, '-')
    pkey_path = File.expand_path("../../fixtures/keys/#{name}.key", __FILE__)
    key = nil

    if File.exist?(pkey_path) && File.readable?(pkey_path)
      data = File.read(pkey_path)
      key = [
        OpenSSL::PKey::RSA,
        OpenSSL::PKey::DSA,
        OpenSSL::PKey::EC,
        OpenSSL::PKey::DH
      ].collect { |klass| instantiate_pkey(data, klass) }.
        detect { |key| !key.nil? }
      data = nil
    end

    key
  end

  ##
  # Returns an OpenSSL::PKey explicitly extended with 
  # OpenSSLExtensions::PKey::PKey.
  #
  def extended_pkeys(name)
    pkeys(name).extend(OpenSSLExtensions::PKey::PKey)
  end


  protected


  def instantiate_pkey(data, klass)
    klass.new(data)
  rescue OpenSSL::PKey::PKeyError
    nil
  end
end

RSpec.configure do |config|
  config.include PKeyFixtures
end
