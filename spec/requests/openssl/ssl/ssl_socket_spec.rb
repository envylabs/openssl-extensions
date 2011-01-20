require 'spec_helper'

describe OpenSSL::SSL::SSLSocket do
  it 'carries the OpenSSLExtensions::SSL::SSLSocket extensions' do
    OpenSSL::SSL::SSLSocket.ancestors.should include(OpenSSLExtensions::SSL::SSLSocket)
  end
end
