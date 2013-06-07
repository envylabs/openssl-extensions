require 'openssl-extensions'
require 'openssl-extensions/x509'

##
# Returned with requesting an OpenSSLExtensions::X509::Certificate.authority_key_identifier.
# If available, this collects the issuer_name (issuer's common name),
# serial_number, and key_id (fingerprint).
#
class OpenSSLExtensions::X509::AuthorityKeyIdentifier

  attr_reader :issuer_name, :serial_number, :key_id
  alias :serial :serial_number

  def initialize(extension_string)
    parse(extension_string.dup) if extension_string
  end


  private


  def common_name(input)
    if input
      name = input.split('/').
        collect { |v| v.split('=') }.
        detect { |id, val| id == 'CN' }
      name[1] if name
    end
  end

  def parse(string)
    Hash[string.scan(%r{(\w+):([^,\n]+)})].tap do |h|
      @issuer_name = common_name(strip(h['DirName']))
      @serial_number = strip(h['serial'])
      @key_id = strip(h['keyid'])
    end
  end

  def strip(input)
    input ? input.to_s.strip : nil
  end
end
