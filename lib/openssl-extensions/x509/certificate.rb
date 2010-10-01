require 'openssl-extensions/x509'
require 'openssl-extensions/x509/authority_key_identifier'

module OpenSSLExtensions::X509::Certificate

  def subject_alternative_names
    names_string = read_extension_by_oid('subjectAltName')
    names_string ? names_string.scan(%r{DNS:([^,]+)}).flatten : []
  end

  def subject_key_identifier
    read_extension_by_oid('subjectKeyIdentifier')
  end

  def authority_key_identifier
    OpenSSLExtensions::X509::AuthorityKeyIdentifier.new(read_extension_by_oid('authorityKeyIdentifier'))
  end

  def read_extension_by_oid(oid)
    (extensions.detect { |e| e.to_a.first == oid } || []).to_a[1]
  end
  protected :read_extension_by_oid

end

OpenSSL::X509::Certificate.send(:include, OpenSSLExtensions::X509::Certificate)
