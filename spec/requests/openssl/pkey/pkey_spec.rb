require 'spec_helper'

describe OpenSSL::PKey::PKey do
  subject { pkeys('rsa') }

  it 'includes the OpenSSLExtensions::PKey::PKey extensions' do
    subject.should be_kind_of OpenSSLExtensions::PKey::PKey
  end
end
