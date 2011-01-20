require 'spec_helper'

describe OpenSSL::X509::Certificate do
  subject { ssl_certificates('www.geocerts.com') }

  it "includes the OpenSSLExtensions::X509::Certificate extensions" do
    subject.should be_kind_of OpenSSLExtensions::X509::Certificate
  end
end
