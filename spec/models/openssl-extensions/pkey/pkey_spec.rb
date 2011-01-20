require 'spec_helper'

describe OpenSSLExtensions::PKey::PKey do
  subject { extended_pkeys('rsa') }

  context '==' do
    it 'is true for matching keys' do
      subject.should == extended_pkeys('rsa')
    end

    it 'is false for mismatched keys' do
      subject.should_not == extended_pkeys('dsa')
    end
  end

  context 'eql?' do
    it 'is true for matching keys' do
      subject.should be_eql extended_pkeys('rsa')
    end

    it 'is false for mismatched keys' do
      subject.should_not be_eql extended_pkeys('dsa')
    end
  end

  context 'hash' do
    it 'returns the hash of the PEM string' do
      subject.stub!(:to_pem => mock('PEM', :hash => 'test'))
      subject.hash
    end
  end
end
