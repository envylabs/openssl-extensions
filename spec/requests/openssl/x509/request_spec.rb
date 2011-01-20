require 'spec_helper'

describe OpenSSL::X509::Request do
  subject { certificate_request('geocerts') }

  it "includes the OpenSSLExtensions::X509::Request extensions" do
    subject.should be_kind_of OpenSSLExtensions::X509::Request
  end
end

