require 'openssl-extensions'
require 'openssl-extensions/x509'
require 'openssl-extensions/x509/authority_key_identifier'

##
# Extends OpenSSL::X509::Certificate with shortcut methods.
#
module OpenSSLExtensions::X509::Certificate
  ##
  # Equality is tested by comparing the generated PEM signatures.
  #
  def ==(other)
    to_pem == other.to_pem
  end
  alias_method :eql?, :==

  ##
  # Returns +true+ if this certificate is authorized to sign for other certificates (useful for determining CA roots
  # and intermediary certificates).
  #
  def allows_certificate_signing?
    usage = read_extension_by_oid('keyUsage')
    usage.nil? || !!(usage.match(%r{\bCertificate Sign\b}))
  end

  def authority_key_identifier
    OpenSSLExtensions::X509::AuthorityKeyIdentifier.new(read_extension_by_oid('authorityKeyIdentifier'))
  end

  ##
  # Override the default Object#hash to identify uniqueness of the
  # Certificate.  This uses a hash of the certificate PEM.
  #
  def hash
    to_pem.hash
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
  # Returns the bit strength of the public certificate.
  #
  def strength
    public_key.strength
  end

  ##
  # Returns a collection of subject alternative names on the certificate.
  # If no alternative names were provided, then this returns an empty set.
  #
  def subject_alternative_names
    names_string = read_extension_by_oid('subjectAltName')
    names_string ? names_string.scan(%r{DNS:([^,]+)}).flatten : []
  end
  alias :sans :subject_alternative_names

  def subject_key_identifier
    read_extension_by_oid('subjectKeyIdentifier')
  end

  ##
  # This can be used for getting OCSP Urls for revocation checks.
  def authority_info_access
    read_extension_by_oid('authorityInfoAccess')
  end

  def crl_distribution_points
    read_extension_by_oid('crlDistributionPoints')
  end

  ##
  # Returns the SSL version used by the certificate.  Most likely, this
  # will return +3+, since version +1+ was unreleased, and version +2+ was
  # abandoned in 1995.
  #
  # See http://en.wikipedia.org/wiki/Secure_Sockets_Layer.
  #
  #--
  # OPTIMIZE: This should really use a call directly to the OpenSSL library, but will require becoming a compiled gem.
  #++
  #
  def ssl_version
    if to_text =~ %r{^\s+Version: (\d+)}m
      $1.to_i
    end
  end


  protected


  def read_extension_by_oid(oid)
    (extensions.detect { |e| e.to_a.first == oid } || []).to_a[1]
  end
end

OpenSSL::X509::Certificate.send(:include, OpenSSLExtensions::X509::Certificate)
