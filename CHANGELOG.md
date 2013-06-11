# openssl-extensions changelog

## [HEAD][unreleased] / unreleased

* No significant changes.

## [1.2.1][v1.2.1] / 2013-06-11

* Fix strength calculation with X509 certificates encrypted with DSA keys.
* Loosen the RSpec dependency requirements to ~> 2.x.
* Fix failing specs in CRL distribution points.

## [1.2.0][v1.2.0] / 2011-11-03

* Extended OpenSSL::BN to provide a #to_hex helper, a shortcut for to_s(16)
  \[[pyrat][pyrat]\]
* Extended OpenSSL::X509::Certificate, adding #authority_info_access and
  #crl_distribution_points methods \[[pyrat][pyrat]\]

## [1.1.0][v1.1.0] / 2011-01-20

* Extended OpenSSL::PKey::PKey to add equality methods

## 1.0.0 / 2011-01-17

* Initial major release.
* Extended OpenSSL::X509::Request, OpenSSL::X509::Certificate,
  OpenSSL::X509::Name
* Added OpenSSLExtensions::X509::CertificateChain and
  OpenSSLExtensions::X509::AuthorityKeyIdentifier


[unreleased]: https://github.com/envylabs/openssl-extensions/compare/v1.2.1...master
[v1.2.1]: https://github.com/envylabs/openssl-extensions/compare/v1.2.0...v1.2.1
[v1.2.0]: https://github.com/envylabs/openssl-extensions/compare/v1.1.0...v1.2.0
[v1.1.0]: https://github.com/envylabs/openssl-extensions/compare/v1.0.0...v1.1.0

[pyrat]: https://github.com/pyrat
