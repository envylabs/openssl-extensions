require 'openssl-extensions/x509'

module OpenSSLExtensions::X509::Name
  def organization
    read_entry_by_oid('O')
  end

  def organizational_unit
    read_entry_by_oid('OU')
  end

  def common_name
    read_entry_by_oid('CN')
  end

  def country
    read_entry_by_oid('C')
  end

  def locality
    read_entry_by_oid('L')
  end

  def state
    read_entry_by_oid('ST')
  end
  alias :region :state


  protected


  def read_entry_by_oid(oid)
    (to_a.detect { |e| e.first == oid } || [])[1]
  end
end

OpenSSL::X509::Name.send(:include, OpenSSLExtensions::X509::Name)
