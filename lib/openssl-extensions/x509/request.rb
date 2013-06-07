require 'openssl-extensions'
require 'openssl-extensions/x509'

##
# Extends OpenSSL::X509::Request with shortcut methods.
#
module OpenSSLExtensions::X509::Request

  ##
  # Equality is tested by comparing the generated PEM signatures.
  #
  def ==(other)
    to_pem == other.to_pem
  end
  alias_method :eql?, :==

  ##
  # Returns +true+ if the signing request were generated with a challenge
  # password.
  #
  def challenge_password?
    !read_attributes_by_oid('challengePassword').nil?
  end

  ##
  # Override the default Object#hash to identify uniqueness of the
  # Request.  This uses a hash of the PEM.
  #
  def hash
    to_pem.hash
  end

  ##
  # Returns the bit strength of the public key used for the signing
  # request.
  #
  def strength
    public_key.n.num_bits
  end

  ##
  # Returns a collection of subject alternative names requested.  If no
  # alternative names were requested, this returns an empty set.
  #
  def subject_alternative_names
    @_subject_alternative_names ||= begin
      if attribute = read_attributes_by_oid('extReq', 'msExtReq')
        set = OpenSSL::ASN1.decode(attribute.value)
        seq = set.value.first
        if sans = seq.value.collect { |asn1ext| OpenSSL::X509::Extension.new(asn1ext).to_a }.detect { |e| e.first == 'subjectAltName' }
          sans[1].gsub(/DNS:/,'').split(', ')
        else
          []
        end
      else
        []
      end
    end
  end
  alias :sans :subject_alternative_names


  protected


  def read_attributes_by_oid(*oids)
    attributes.detect { |a| oids.include?(a.oid) }
  end
end

OpenSSL::X509::Request.send(:include, OpenSSLExtensions::X509::Request)
