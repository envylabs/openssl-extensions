# OpenSSL Extensions

This library generally provides helper methods which makes working with
OpenSSL a little more bearable.  It does, however, provide some additional
structures (such as a CertificateChain) which extend the traditional
features of the library.

## Installation

With [Bundler](http://gembundler.com):

    gem 'openssl-extensions', :require => 'openssl-extensions/all'

With standard RubyGems:

    gem install openssl-extensions

    require 'rubygems'
    require 'openssl-extensions/all'

Once required, the extensions are automatically applied.

## Usage

In general, this extension library should be somewhat transparent to you.
It does not directly provide many classes with which you might interact.
Instead, it extends the current classes provided by Ruby's OpenSSL library
(being OpenSSL::X509::Request, OpenSSL::X509::Certificate, and
OpenSSL::X509::NAME).

Below is a simple example exercising a few helpers provided by this 
library:

    csr_body = File.read('example.csr') # assuming this is valid and exists
    request = OpenSSL::X509::Request.new(csr_body)
    
    request.subject.common_name         # => "example.com"
    request.subject.organization        # => "Example Corp"
    request.subject.locality            # => "Orlando"
    request.subject.region              # => "Florida"
    request.subject.country             # => "US"
    request.subject.location            # => "Orlando, Florida, US"
    
    request.strength                    # => 2048
    request.challenge_password?         # => false
    request.subject_alternative_names   # => ['example.com', 'www.example.com']

## License

Released under the MIT License. See the LICENSE file for further details.
