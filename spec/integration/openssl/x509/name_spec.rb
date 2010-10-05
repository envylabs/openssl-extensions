require 'spec_helper'

describe OpenSSL::X509::Name do
  subject { ssl_certificates('www.geocerts.com').issuer }

  it "includes the OpenSSLExtensions::X509::Name extensions" do
    subject.should be_kind_of OpenSSLExtensions::X509::Name
  end
end
