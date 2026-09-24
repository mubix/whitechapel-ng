# Load the Rex pieces the app uses for hash generation (the top-level "rex"
# require is lightweight and is loaded by Bundler automatically).
require "openssl"

# Define the base module so rex's sub-libraries load without the
# top-level rex.rb (which overloads Kernel#sleep and Kernel#select
# and breaks ActionView 7.2's tag builder).
module Rex
end

require "rex/text"
require "rex/proto/ntlm/crypt"

begin
  OpenSSL::Digest::MD4.digest("")
rescue StandardError
  # MD4 was removed from OpenSSL 3, so fall back to a pure-Ruby
  # implementation (RFC 1320) to keep NTLM hashing working.
  require "md4"

  class Rex::Proto::NTLM::Crypt
    class << self
      def ntlm_hash(password, opt = {})
        pwd = password.dup
        pwd = Rex::Text.to_unicode(pwd) unless opt[:unicode]
        ::Md4.md4(pwd)
      end
    end
  end
end

begin
  OpenSSL::Cipher::DES.new
rescue StandardError
  # DES-ECB moved to the OpenSSL 3 legacy provider, which is usually
  # unavailable. Rex::Proto::NTLM::Crypt needs it for LANMAN (LM)
  # hashing, so fall back to a pure-Ruby single-DES implementation.
  require "des56"

  class Rex::Proto::NTLM::Crypt
    def self.apply_des(plain, keys)
      keys.map { |key| ::Des56.encrypt(plain, key) }
    end
  end
end
