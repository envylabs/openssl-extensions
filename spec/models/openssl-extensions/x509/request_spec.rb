require 'spec_helper'

describe OpenSSLExtensions::X509::Request do
  subject { extended_certificate_request('geocerts') }

  context 'subject_alternative_names' do
    context 'on a CSR with SANs' do
      subject { extended_certificate_request('sans') }
      it 'returns a collection of the alternative names' do
        subject.subject_alternative_names.should ==
          ['mail.sipchem.local',
            'mail.sipchem.com',
            'sipchem.com',
            'autodiscover.sipchem.local',
            'autodiscover.sipchem.com',
            'sipc-cas01',
            'sipc-cas02',
            'sipchem.local' ]
      end
    end

    context 'on a CSR without SANs' do
      it 'returns an empty collection' do
        subject.subject_alternative_names.should == []
      end
    end
  end

  context 'challenge_password?' do
    context 'on a CSR with a challenge password' do
      subject { extended_certificate_request('challenge') }
      its(:challenge_password?) { should be_true }
    end

    context 'on a CSR without a challenge password' do
      its(:challenge_password?) { should be_false }
    end
  end

  context 'strength' do
    it 'is 2048 bits' do
      subject.strength.should == 2048
    end

    it 'is 1024 bits' do
      extended_certificate_request('1024').strength.should == 1024
    end
  end

  context 'equality (==)' do
    it 'is true with matching PEMs' do
      extended_certificate_request('geocerts').should ==
        extended_certificate_request('geocerts')
    end

    it 'is false with mismatched PEMs' do
      certificate = extended_certificate_request('geocerts')
      certificate.should_receive(:to_pem).and_return('DIFFERENTPEM')
      extended_certificate_request('geocerts').should_not == certificate
    end
  end

  context 'in a collection, uniq' do
    it 'removes duplicate certificates' do
      [extended_certificate_request('geocerts'),
        extended_certificate_request('geocerts')].uniq.should ==
        [extended_certificate_request('geocerts')]
    end

    it 'does not modify non-duplicates' do
      [extended_certificate_request('geocerts'),
        extended_certificate_request('1024')].uniq.should ==
      [extended_certificate_request('geocerts'),
        extended_certificate_request('1024')]
    end
  end
end
