require 'spec_helper'

describe OpenSSLExtensions::X509::Certificate do
  let(:certificate) { extended_ssl_certificates('www.geocerts.com') }
  subject { certificate }

  its(:subject_alternative_names) { should == %w(www.geocerts.com geocerts.com) }
  its(:subject_key_identifier) { should be_nil }
  its(:authority_key_identifier) { should be_kind_of(OpenSSLExtensions::X509::AuthorityKeyIdentifier) }
  its(:ssl_version) { should == 3 }

  context 'strength' do
    subject { certificate.strength }

    context 'for a 2048 bit certificate' do
      it { should == 2048 }
    end

    context 'for a 1024 bit RSA-signed certificate' do
      let(:certificate) { extended_ssl_certificates('www.twongo.com') }

      it { should == 1024 }
    end

    context 'for a 1024 bit DSA-signed certificate' do
      let(:certificate) { extended_ssl_certificates('bgthelpdesk.braxtongrant.com') }

      it { should == 1024 }
    end
  end

  context 'allows_certificate_signing?' do
    subject { certificate.allows_certificate_signing? }

    context 'for V3' do
      context 'for a root certificate' do
        let(:certificate) { extended_ssl_certificates('GeoTrust Primary Certification Authority') }
        it { should be_true }
      end

      context 'for a site certificate' do
        it { should be_false }
      end
    end

    context 'for V1' do
      context 'for a root certificate' do
        let(:certificate) { extended_ssl_certificates('HongKong Post Root CA 1') }
        it { should be_true }
      end

      context 'for a site certificate' do
        let(:certificate) { extended_ssl_certificates('app1.hongkongpost.com') }
        it { should be_false }
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
      ssl_certificates('www.geocerts.com').
        should == ssl_certificates('www.geocerts.com')
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

  context 'subject_key_identifier' do
    subject { ssl_certificates('GeoTrust Extended Validation SSL CA').extend(OpenSSLExtensions::X509::Certificate).subject_key_identifier }

    it { should == '28:C4:EB:8F:F1:5F:79:90:A3:2B:55:C3:56:4E:7D:6B:53:72:2C:18' }
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

  context 'serial' do
    context 'to_hex' do
      let(:certificate) { extended_ssl_certificates('GeoTrust Extended Validation SSL CA') }
      subject { certificate.serial.to_hex }

      it 'returns the base 16 (hex) format of the serial number' do
        should eq('6948A26B201AA421E898B1C492C7C58E')
      end
    end
  end

  context 'crl_distribution_points' do
    subject { certificate.crl_distribution_points }

    it { should be_a String }
    it { should include "URI:http://EVSSL-crl.geotrust.com/crls/gtextvalca.crl" }
  end

  context 'authority_info_access' do
    subject { certificate.authority_info_access }

    it { should be_a String }
    it { should include "OCSP - URI:http://EVSSL-ocsp.geotrust.com" }
    it { should include "CA Issuers - URI:http://EVSSL-aia.geotrust.com/evca.crt" }
  end
end
