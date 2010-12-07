require 'spec_helper'

describe OpenSSLExtensions::X509::Name do
  subject { ssl_certificates('www.geocerts.com').subject.extend(OpenSSLExtensions::X509::Name) }

  its(:organization) { should == 'GeoCerts Inc' }
  its(:organizational_unit) { should == 'SSL Sales' }
  its(:common_name) { should == 'www.geocerts.com' }
  its(:country) { should == 'US' }
  its(:locality) { should == 'Atlanta' }
  its(:state) { should == 'Georgia' }
  its(:region) { should == 'Georgia' }

  context 'with an email address' do
    subject { certificate_request('envylabs').subject.extend(OpenSSLExtensions::X509::Name) }
    its(:email) { should == 'support@envylabs.com' }
  end

  its(:location) { should == 'Atlanta, Georgia, US' }
end
