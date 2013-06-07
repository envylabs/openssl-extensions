module OpenSSLExtensions
  ##
  # Ensures that the current Ruby was compiled with OpenSSL support enabled.
  #
  def self.check_dependencies!
    begin
      require 'openssl'
    rescue LoadError
      $stderr.puts "OpenSSLExtensions requires Ruby to be compiled with OpenSSL support."
      exit(1)
    end
  end
end
