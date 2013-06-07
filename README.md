# OpenSSL Extensions

[![Gem Version](https://badge.fury.io/rb/openssl-extensions.png)](http://badge.fury.io/rb/openssl-extensions)
[![Build Status](https://secure.travis-ci.org/envylabs/openssl-extensions.png?branch=master)](http://travis-ci.org/envylabs/openssl-extensions)
[![Code Climate](https://codeclimate.com/github/envylabs/openssl-extensions.png)](https://codeclimate.com/github/envylabs/openssl-extensions)

This library generally provides helper methods which makes working with
OpenSSL a little more bearable.  It does, however, provide some additional
structures (such as a CertificateChain) which extend the traditional
features of the library.

## Installation

With [Bundler](http://gembundler.com):

```ruby
gem 'openssl-extensions', :require => 'openssl-extensions/all'
```

With standard RubyGems:

```shell
gem install openssl-extensions
```

```ruby
require 'rubygems'
require 'openssl-extensions/all'
```

Once required, the extensions are automatically applied.

## Usage

In general, this extension library should be somewhat transparent to you.
It does not directly provide many classes with which you might interact.
Instead, it extends the current classes provided by Ruby's OpenSSL library
(being OpenSSL::X509::Request, OpenSSL::X509::Certificate, and
OpenSSL::X509::NAME).

Below is a simple example exercising a few helpers provided by this 
library:

```ruby
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
```

## Supported Ruby Implementations

This OpenSSL extension library currently supports (and is continuously tested
against) the following Ruby implementations:

* [MRI 1.8.7][mri]
* [MRI 1.9.2][mri]
* [MRI 1.9.3][mri]
* [Ruby Enterprise Edition][ree]
* [Rubinius][rubinius]

The following implementations are known to be incompatible:

* [JRuby][jruby]

## License

Released under the MIT License. See the LICENSE file for further details.

[mri]: http://www.ruby-lang.org/
[ree]: http://www.rubyenterpriseedition.com/
[rubinius]: http://rubini.us/
[jruby]: http://jruby.org/
