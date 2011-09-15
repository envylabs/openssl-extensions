require 'spec_helper'

describe OpenSSLExtensions::X509::Certificate do
  subject { extended_ssl_certificates('www.geocerts.com') }

  its(:subject_alternative_names) { should == %w(www.geocerts.com geocerts.com) }
  its(:subject_key_identifier) { should be_nil }
  its(:authority_key_identifier) { should be_kind_of(OpenSSLExtensions::X509::AuthorityKeyIdentifier) }
  its(:ssl_version) { should == 3 }

  context 'strength' do
    it 'is 2048 bits' do
      subject.strength.should == 2048
    end

    it 'is 1024 bits' do
      extended_ssl_certificates('www.twongo.com').strength.should == 1024
    end
  end

  context 'allows_certificate_signing?' do
    context 'for V3' do
      it 'is true for a root certificate' do
        extended_ssl_certificates('GeoTrust Primary Certification Authority').allows_certificate_signing?.should be_true
      end

      it 'is false for a site certificate' do
        extended_ssl_certificates('www.geocerts.com').allows_certificate_signing?.should be_false
      end
    end

    context 'for V1' do
      it 'is true for a root certificate' do
        extended_ssl_certificates('HongKong Post Root CA 1').allows_certificate_signing?.should be_true
      end

      it 'is false for a site certificate' do
        extended_ssl_certificates('app1.hongkongpost.com').allows_certificate_signing?.should be_false
      end
    end
  end

  context 'issuing_certificate?' do
    context 'for V3' do
      it 'is true when passing the issuing certificate' do
        extended_ssl_certificates('www.geocerts.com').
          issuing_certificate?(extended_ssl_certificates('GeoTrust Extended Validation SSL CA')).should be_true
      end

      it 'is false when passing the distant root certificate' do
        extended_ssl_certificates('www.geocerts.com').
          issuing_certificate?(extended_ssl_certificates('GeoTrust Primary Certification Authority')).should be_false
      end

      it 'is false when passing a different site certificate' do
        extended_ssl_certificates('www.geocerts.com').
          issuing_certificate?(extended_ssl_certificates('www.twongo.com'))
      end
    end
  end

  context 'equality (==)' do
    it 'is true with matching PEMs' do
      ssl_certificates('www.geocerts.com').should == ssl_certificates('www.geocerts.com')
    end

    it 'is false with mismatched PEMs' do
      certificate = ssl_certificates('www.geocerts.com')
      certificate.should_receive(:to_pem).and_return('DIFFERENTPEM')
      ssl_certificates('www.geocerts.com').should_not == certificate
    end
  end

  context 'in a collection, uniq' do
    it 'removes duplicate certificates' do
      [ssl_certificates('www.geocerts.com'),
        ssl_certificates('www.geocerts.com')].uniq.should ==
        [ssl_certificates('www.geocerts.com')]
    end

    it 'does not modify non-duplicates' do
      [ssl_certificates('www.geocerts.com'),
        ssl_certificates('GeoTrust Extended Validation SSL CA')].uniq.should ==
      [ssl_certificates('www.geocerts.com'),
        ssl_certificates('GeoTrust Extended Validation SSL CA')]
    end
  end

  context 'when a subject key identifier is provided' do

    subject { ssl_certificates('GeoTrust Extended Validation SSL CA').extend(OpenSSLExtensions::X509::Certificate) }

    its(:subject_key_identifier) { should == '28:C4:EB:8F:F1:5F:79:90:A3:2B:55:C3:56:4E:7D:6B:53:72:2C:18' }
  end

  context 'root?' do
    it 'is false for a certificate with a separate issuer' do
      extended_ssl_certificates('www.geocerts.com').should_not be_root
    end

    it 'is true for a certificate which is its own issuer' do
      extended_ssl_certificates('equifax-secure-ca').should be_root
    end

    it 'is true for a certificate with a matching subject and issuer, subject identifier given, but no authority identifier provided' do
      extended_ssl_certificates('globalsign-root-ca').should be_root
    end
  end
  
  context 'hexserial' do
    
    subject { ssl_certificates('GeoTrust Extended Validation SSL CA').extend(OpenSSLExtensions::X509::Certificate) }

    its(:hex_serial) { should == '6948A26B201AA421E898B1C492C7C58E' }
    
  end
  
  
end
