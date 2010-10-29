require 'openssl-extensions/x509'
require 'openssl-extensions/x509/authority_key_identifier'

##
# Extends OpenSSL::X509::Certificate with shortcut methods.
#
module OpenSSLExtensions::X509::Certificate

  def subject_alternative_names
    names_string = read_extension_by_oid('subjectAltName')
    names_string ? names_string.scan(%r{DNS:([^,]+)}).flatten : []
  end
  alias :sans :subject_alternative_names

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

  ##
  # Returns +true+ if this certificate is authorized to sign for other certificates (useful for determining CA roots
  # and intermediary certificates).
  #
  def allows_certificate_signing?
    usage = read_extension_by_oid('keyUsage')
    usage.nil? || !!(usage.match(%r{\bCertificate Sign\b}))
  end

  ##
  # Returns +true+ if the certificate given is the issuer certificate for this certificate.
  #
  def issuing_certificate?(issuer)
    (self.authority_key_identifier.key_id &&
      issuer.subject_key_identifier &&
      self.authority_key_identifier.key_id == issuer.subject_key_identifier) ||
      (!self.authority_key_identifier.key_id &&
       self.issuer.common_name == issuer.subject.common_name &&
       self.issuer.country == issuer.subject.country &&
       self.issuer.organization == issuer.subject.organization)
  end

  ##
  # Returns +true+ if this certificate is a root certificate (it is its
  # own issuer).
  #
  def root?
    issuer.to_s == subject.to_s &&
      (subject_key_identifier && authority_key_identifier.key_id ? subject_key_identifier == authority_key_identifier.key_id : true)
  end

  ##
  # Equality is tested by comparing the generated PEM signatures.
  #
  def ==(other)
    to_pem == other.to_pem
  end
  alias_method :eql?, :==

  ##
  # Override the default Object#hash to identify uniqueness of the
  # Certificate.  This uses a hash of the certificate PEM.
  # 
  def hash
    to_pem.hash
  end
end

OpenSSL::X509::Certificate.send(:include, OpenSSLExtensions::X509::Certificate)
