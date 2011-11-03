## 1.2.0, released 2011-11-03

[full changelog](http://github.com/envylabs/openssl-extensions/compare/v1.1.0...v1.2.0)

**Enhancements**

* Extended OpenSSL::BN to provide a #to_hex helper, a shortcut for to_s(16) \[[pyrat](https://github.com/pyrat)\]
* Extended OpenSSL::X509::Certificate, adding #authority_info_access and #crl_distribution_points methods \[[pyrat](https://github.com/pyrat)\]

## 1.1.0, released 2011-01-20

[full changelog](http://github.com/envylabs/openssl-extensions/compare/v1.0.0...v1.1.0)

**Enhancements**

* Extended OpenSSL::PKey::PKey to add equality methods

## 1.0.0, released 2011-01-17

* Initial major release.
* Extended OpenSSL::X509::Request, OpenSSL::X509::Certificate, OpenSSL::X509::Name
* Added OpenSSLExtensions::X509::CertificateChain and OpenSSLExtensions::X509::AuthorityKeyIdentifier

