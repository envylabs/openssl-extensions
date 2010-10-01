require 'openssl-extensions/x509'

class OpenSSLExtensions::X509::AuthorityKeyIdentifier

  attr_reader :issuer_name, :serial_number, :key_id
  alias :serial :serial_number

  def initialize(extension_string)
    parse(extension_string.dup)
  end

  def parse(string)
    Hash[string.scan(%r{(\w+):([^,\n]+)})].tap do |h|
      @issuer_name = common_name(strip(h['DirName']))
      @serial_number = strip(h['serial'])
      @key_id = strip(h['keyid'])
    end
  end
  private :parse

  def strip(input)
    input ? input.to_s.strip : nil
  end
  private :strip

  def common_name(input)
    if input
      name = input.split('/').
        collect { |v| v.split('=') }.
        detect { |id, val| id == 'CN' }
      name[1] if name
    end
  end
  private :common_name

end
