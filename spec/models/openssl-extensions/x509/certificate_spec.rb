require 'spec_helper'

describe OpenSSLExtensions::X509::Certificate do
  subject do
    OpenSSL::X509::Certificate.new(<<-CERTIFICATE).extend(OpenSSLExtensions::X509::Certificate)
-----BEGIN CERTIFICATE-----
MIIFaDCCBFCgAwIBAgICCokwDQYJKoZIhvcNAQEFBQAwgYUxCzAJBgNVBAYTAlVT
MRUwEwYDVQQKEwxHZW9UcnVzdCBJbmMxMTAvBgNVBAsTKFNlZSB3d3cuZ2VvdHJ1
c3QuY29tL3Jlc291cmNlcy9jcHMgKGMpMDYxLDAqBgNVBAMTI0dlb1RydXN0IEV4
dGVuZGVkIFZhbGlkYXRpb24gU1NMIENBMB4XDTEwMDYxODIwNTUwNloXDTEyMDgx
MjE0MTkwNVowgdUxGzAZBgNVBA8TElYxLjAsIENsYXVzZSA1LihiKTETMBEGCysG
AQQBgjc8AgEDEwJVUzEYMBYGCysGAQQBgjc8AgECEwdHZW9yZ2lhMRAwDgYDVQQF
EwcwNDUwNzcxMQswCQYDVQQGEwJVUzEQMA4GA1UECBMHR2VvcmdpYTEQMA4GA1UE
BxMHQXRsYW50YTEVMBMGA1UEChMMR2VvQ2VydHMgSW5jMRIwEAYDVQQLEwlTU0wg
U2FsZXMxGTAXBgNVBAMTEHd3dy5nZW9jZXJ0cy5jb20wggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCfSaBRuqglkqNaIRqdd2CzPOVdw14YPheWEOG28iFI
Oi+Pzjk0XU+KFEJ3ID7aC+ntyb/CjXjOiv7k9Xrjp4+y4e/bXPr4Cz1SSQwYtY5Q
6xbUnRXkCn3SETsGeub8pKM/KCJB0Tbmmtqw7TgJbGSHTbWNkxTY9oUIMRYx44sE
2LLh2o08WMiYrFO2L9kRyR6rn4tLL7RGj4Q2ZZbWG4xzkwDL4GhZ9eUnOFz7vzWc
CB+EAggMlM8pck1bJD/7z8qCMbV7h/NYJFDRb8Gd1skBd0b58tYlY8sn+P9qYRWc
oWUWES8XSP/HUehuLKIzIy0JckAt88U8rRy4DLP9rD3BAgMBAAGjggGOMIIBijAf
BgNVHSMEGDAWgBQoxOuP8V95kKMrVcNWTn1rU3IsGDBuBggrBgEFBQcBAQRiMGAw
KgYIKwYBBQUHMAGGHmh0dHA6Ly9FVlNTTC1vY3NwLmdlb3RydXN0LmNvbTAyBggr
BgEFBQcwAoYmaHR0cDovL0VWU1NMLWFpYS5nZW90cnVzdC5jb20vZXZjYS5jcnQw
DgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjAp
BgNVHREEIjAgghB3d3cuZ2VvY2VydHMuY29tggxnZW9jZXJ0cy5jb20wQgYDVR0f
BDswOTA3oDWgM4YxaHR0cDovL0VWU1NMLWNybC5nZW90cnVzdC5jb20vY3Jscy9n
dGV4dHZhbGNhLmNybDAMBgNVHRMBAf8EAjAAMEsGA1UdIAREMEIwQAYJKwYBBAHw
IgEGMDMwMQYIKwYBBQUHAgEWJWh0dHA6Ly93d3cuZ2VvdHJ1c3QuY29tL3Jlc291
cmNlcy9jcHMwDQYJKoZIhvcNAQEFBQADggEBAIppmd9Lm9+cbSPrKKlIdunEbwTU
kquqmCaJP7tP6ASb2NfJczfzpdlxidiVOp1wJxIHhuAQjhWt0nO7aOTjMD8WZa1d
NIQMWHeFyhAuqJFXtJ6Ha9t1CB+V3ksNNKIhR5urZXlRc4G7Y2udyIYuqq4VzWsS
TFCS6/lAuDob4h5+TEdm51CV6BFyJweYt4o1FKSDVKwQmRMmc4Tk2oyBlX4jKPdS
WPKMKb7f934e69sZlne575+Ml4FJm3g2QK+AR/2rSuQsO2vV+stkhknLZsCIrrkh
9zClcbFt/pHG1LTI0KNs87Eix3avl2uLIzb9MSyQbKPbtDXlH+fqSAao/mY=
-----END CERTIFICATE-----
CERTIFICATE
  end

  its(:subject_alternative_names) { should == %w(www.geocerts.com geocerts.com) }
  its(:subject_key_identifier) { should be_nil }
  its(:authority_key_identifier) { should be_kind_of(OpenSSLExtensions::X509::AuthorityKeyIdentifier) }

  context 'when a subject key identifier is provided' do

    subject do
      OpenSSL::X509::Certificate.new(<<-CERT).extend(OpenSSLExtensions::X509::Certificate)
-----BEGIN CERTIFICATE-----
MIIEnDCCA4SgAwIBAgIQaUiiayAapCHomLHEksfFjjANBgkqhkiG9w0BAQUFADBY
MQswCQYDVQQGEwJVUzEWMBQGA1UEChMNR2VvVHJ1c3QgSW5jLjExMC8GA1UEAxMo
R2VvVHJ1c3QgUHJpbWFyeSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0wNjEx
MjkwMDAwMDBaFw0xNjExMjgyMzU5NTlaMIGFMQswCQYDVQQGEwJVUzEVMBMGA1UE
ChMMR2VvVHJ1c3QgSW5jMTEwLwYDVQQLEyhTZWUgd3d3Lmdlb3RydXN0LmNvbS9y
ZXNvdXJjZXMvY3BzIChjKTA2MSwwKgYDVQQDEyNHZW9UcnVzdCBFeHRlbmRlZCBW
YWxpZGF0aW9uIFNTTCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AMLv7ewLLXKKdGhzNm4QqH5If1i7eGfc7XvWfKZPPZ9dbwrQoLRl/b7Tv3e2lKWC
/4GVnSgQBuzCtJCqWlFMc9lrdKg1SfSmNoDUXHWennwBx4ycgciGgxqOvQATotz/
pXiqdywhYgiXP4C992ekedt91z5uttWWuZiGTnpn4pOv2qXRJ/vxZsMqAwy2x4Id
Ofs83ik2cV3hqLUWOXwb/3uG9YCSleADO6pE+/QAteWp4voY+YSaweH2Lg6BixQp
NP8fVWCIpJnGb28EOTp1pKceWN+3/8maHXDbg6DTgxstbSqQW6NjkXO1/52CekHz
06ovCw2fz0TAXseha8+ulNsCAwEAAaOCATIwggEuMB0GA1UdDgQWBBQoxOuP8V95
kKMrVcNWTn1rU3IsGDA9BggrBgEFBQcBAQQxMC8wLQYIKwYBBQUHMAGGIWh0dHA6
Ly9FVlNlY3VyZS1vY3NwLmdlb3RydXN0LmNvbTASBgNVHRMBAf8ECDAGAQH/AgEA
MEYGA1UdIAQ/MD0wOwYEVR0gADAzMDEGCCsGAQUFBwIBFiVodHRwOi8vd3d3Lmdl
b3RydXN0LmNvbS9yZXNvdXJjZXMvY3BzMEEGA1UdHwQ6MDgwNqA0oDKGMGh0dHA6
Ly9FVlNlY3VyZS1jcmwuZ2VvdHJ1c3QuY29tL0dlb1RydXN0UENBLmNybDAOBgNV
HQ8BAf8EBAMCAQYwHwYDVR0jBBgwFoAULNVQQZcVi/CPNmFbSvtr2ZnJM5IwDQYJ
KoZIhvcNAQEFBQADggEBAAJgoxYSndgcGeRaN2z/Mpg3Rk+8gXyAw8qJKgD+Xj7s
uowrH6uVa5GUIaBgHwIG+s8XbfiVq814IxSWwJ0fG+tQ4WVCitKzya2Aw2fPtFgb
1QTkWP40ReD7pIQii+niN0yY8Qv/pIlT0U3AaEjXWYcaO3310Pkjcspg/cMiFfCa
lVhvfCST7KUSPbQbAejuae1Ba1LLmrdcFdG9BkB64AyXy2Dngl9qX95JhFZqr3yw
S62MTw95oMwRPCXnRr960C+IyL/rlAtqdTN/cwC4EnAjXlV/RVseELECaNgnQM8k
CeJldM6JRI17KJBorqzCOMhWDTOIKH9U/Dw8UAmTPTg=
-----END CERTIFICATE-----
CERT
    end

    its(:subject_key_identifier) { should == '28:C4:EB:8F:F1:5F:79:90:A3:2B:55:C3:56:4E:7D:6B:53:72:2C:18' }
  end
end
