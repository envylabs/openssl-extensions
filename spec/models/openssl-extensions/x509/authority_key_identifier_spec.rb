require 'spec_helper'

describe OpenSSLExtensions::X509::AuthorityKeyIdentifier do
  context 'using a V1 identifier' do
    subject { OpenSSLExtensions::X509::AuthorityKeyIdentifier.new('DirName:/C=HK/O=Hongkong Post/CN=Hongkong Post Root CA 1, serial:03:ED') }

    its(:issuer_name) { should == 'Hongkong Post Root CA 1' }
    its(:serial_number) { should == '03:ED' }
    its(:serial) { should == '03:ED' }
  end

  context 'using a V3 identifier' do
    subject { OpenSSLExtensions::X509::AuthorityKeyIdentifier.new("keyid:28:C4:EB:8F:F1:5F:79:90:A3:2B:55:C3:56:4E:7D:6B:53:72:2C:18\n") }

    its(:key_id) { should == '28:C4:EB:8F:F1:5F:79:90:A3:2B:55:C3:56:4E:7D:6B:53:72:2C:18' }
  end
end
