require 'spec_helper'

describe OpenSSLExtensions::SSL::SSLSocket do
  context 'peer_cert_chain' do
    it 'delegates to OpenSSLExtensions::X509::CertificateChain' do
      pending 'Figure out how to stub the IO required for SSLSocket without using an actual File or TCPSocket.'
      OpenSSLExtensions::X509::CertificateChain.
        should_receive(:new).
        with(an_instance_of(OpenSSL::X509::Certificate),
             an_instance_of(Array)).
        once.
        and_return([])
      subject.peer_cert_chain
    end
  end
end
