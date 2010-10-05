require 'spec_helper'

describe OpenSSLExtensions::X509::CertificateChain do
  context 'with SSL V3 certificates' do
    subject do
      OpenSSLExtensions::X509::CertificateChain.
        new(ssl_certificates('www.geocerts.com'), [ssl_certificates('www.geocerts.com'),
            ssl_certificates('GeoTrust Primary Certification Authority'),
            ssl_certificates('GeoTrust Extended Validation SSL CA') ])
    end

    it 'is the correct size' do
      subject.size.should == 3
    end

    it 'reports itself as an Array' do
      subject.class.should == Array
    end

    it 'is in the correct order' do
      subject.should == [ssl_certificates('www.geocerts.com'),
        ssl_certificates('GeoTrust Extended Validation SSL CA'),
        ssl_certificates('GeoTrust Primary Certification Authority')]
    end
  end

  context 'with SSL V1 certificates' do
    subject do
      OpenSSLExtensions::X509::CertificateChain.
        new(ssl_certificates('app1.hongkongpost.com'), [ssl_certificates('app1.hongkongpost.com'),
            ssl_certificates('Hongkong Post e-Cert CA'),
            ssl_certificates('Hongkong Post Root CA'),
            ssl_certificates('Hongkong Post e-Cert CA 1'),
            ssl_certificates('Hongkong Post Root CA 1') ])
    end

    it 'filters out unlinked certificates' do
      subject.should_not include(ssl_certificates('Hongkong Post e-Cert CA'))
      subject.should_not include(ssl_certificates('Hongkong Post Root CA'))
    end

    it 'includes chained certificates' do
      subject.should include(ssl_certificates('app1.hongkongpost.com'))
      subject.should include(ssl_certificates('Hongkong Post e-Cert CA 1'))
      subject.should include(ssl_certificates('Hongkong Post Root CA 1'))
    end

    it 'is in the correct order' do
      subject.should == [ssl_certificates('app1.hongkongpost.com'),
        ssl_certificates('Hongkong Post e-Cert CA 1'),
        ssl_certificates('Hongkong Post Root CA 1')]
    end
  end
end
