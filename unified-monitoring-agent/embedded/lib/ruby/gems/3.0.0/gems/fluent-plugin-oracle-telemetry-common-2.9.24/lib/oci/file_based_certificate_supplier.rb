# frozen_string_literal: true

require 'openssl'

module OCI
  # certificate supplier using local file, this class needs to provide
  # same functionality as UrlBasedCertificateRetriever.
  class FileBasedCertificateSupplier

    def initialize(certificate_path, private_key_path: nil)
      @certificate_path = certificate_path
      @private_key_path = private_key_path
    end

    def certificate
      pem = File.read(@certificate_path)
      OpenSSL::X509::Certificate.new(pem)
    end

    def certificate_pem
      File.read(@certificate_path)
    end

    def private_key_pem
      @private_key_path.nil? ? nil : File.read(@private_key_path)
    end

    def refresh
      # noop
    end
  end
end