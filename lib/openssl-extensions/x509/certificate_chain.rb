require 'openssl-extensions'
require 'openssl-extensions/x509'
require 'openssl-extensions/x509/certificate'

##
# Provides a thin wrapper to an Array which contains the full certificate
# chain.  This array, however, has been reorganized to be in the proper
# order for the chain as follows:
#
#     [Site Certificate, Intermediary #1, ..., CA Root]
#
# Where +Intermediary #1+ is the issuing certificate of the
# +Site Certificate+, followed by +#2+ which issued +#1+, down to the
# final root signing certificate in last position.
#
class OpenSSLExtensions::X509::CertificateChain
  instance_methods.each { |m| undef_method m unless m =~ /(^__|^send$|^object_id$)/ }

  def initialize(peer_certificate, certificates)
    @certificates = []
    reorganize!(peer_certificate, certificates)
  end


  private


  def method_missing(method, *args, &block)
    @certificates.send(method, *args, &block)
  end

  def reorganize!(site_certificate, certificates)
    return unless site_certificate && !certificates.empty?
    certificate = nil

    @certificates << (certificates.delete(site_certificate) || site_certificate || certificates.delete(certificates.detect { |c| c.subject_key_identifier.nil? }))
    certificate = @certificates.first

    until certificate.nil?
      if certificate = certificates.detect { |authority| authority.allows_certificate_signing? && certificate.issuing_certificate?(authority) }
        @certificates << certificates.delete(certificate)
      else
        authority = nil
      end
    end
  end
end
