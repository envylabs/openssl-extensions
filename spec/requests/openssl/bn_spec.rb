require 'spec_helper'

describe OpenSSL::BN do
  subject { ssl_certificates('www.geocerts.com').serial }

  it "includes the OpenSSLExtensions::BN extensions" do
    subject.should be_kind_of OpenSSLExtensions::BN
  end
end
