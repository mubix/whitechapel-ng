# Pure-Ruby MD4 implementation (RFC 1320).
#
# OpenSSL 3 no longer ships MD4 (it moved to the legacy provider), but
# Rex::Proto::NTLM::Crypt#ntlm_hash needs it. This implementation is used
# as a fallback by config/initializers/rex_ntlm.rb.
module Md4
  MASK = 0xFFFFFFFF

  def self.md4(data)
    data = data.b
    msg_len = data.bytesize
    data += "\x80".b
    data += "\x00".b * ((55 - msg_len) % 64)
    data += [msg_len * 8 % (2**64)].pack("Q<")

    a, b, c, d = 0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476

    data.bytes.each_slice(64) do |chunk_bytes|
      x = chunk_bytes.each_slice(4).map { |w| w[0] | (w[1] << 8) | (w[2] << 16) | (w[3] << 24) }
      aa, bb, cc, dd = a, b, c, d

      # Round 1 (F): shifts 3,7,11,19
      aa = step(aa, bb, cc, dd, x[0], 3, 0)
      dd = step(dd, aa, bb, cc, x[1], 7, 0)
      cc = step(cc, dd, aa, bb, x[2], 11, 0)
      bb = step(bb, cc, dd, aa, x[3], 19, 0)
      aa = step(aa, bb, cc, dd, x[4], 3, 0)
      dd = step(dd, aa, bb, cc, x[5], 7, 0)
      cc = step(cc, dd, aa, bb, x[6], 11, 0)
      bb = step(bb, cc, dd, aa, x[7], 19, 0)
      aa = step(aa, bb, cc, dd, x[8], 3, 0)
      dd = step(dd, aa, bb, cc, x[9], 7, 0)
      cc = step(cc, dd, aa, bb, x[10], 11, 0)
      bb = step(bb, cc, dd, aa, x[11], 19, 0)
      aa = step(aa, bb, cc, dd, x[12], 3, 0)
      dd = step(dd, aa, bb, cc, x[13], 7, 0)
      cc = step(cc, dd, aa, bb, x[14], 11, 0)
      bb = step(bb, cc, dd, aa, x[15], 19, 0)

      # Round 2 (G): shifts 3,5,9,13
      aa = step(aa, bb, cc, dd, x[0], 3, 1)
      dd = step(dd, aa, bb, cc, x[4], 5, 1)
      cc = step(cc, dd, aa, bb, x[8], 9, 1)
      bb = step(bb, cc, dd, aa, x[12], 13, 1)
      aa = step(aa, bb, cc, dd, x[1], 3, 1)
      dd = step(dd, aa, bb, cc, x[5], 5, 1)
      cc = step(cc, dd, aa, bb, x[9], 9, 1)
      bb = step(bb, cc, dd, aa, x[13], 13, 1)
      aa = step(aa, bb, cc, dd, x[2], 3, 1)
      dd = step(dd, aa, bb, cc, x[6], 5, 1)
      cc = step(cc, dd, aa, bb, x[10], 9, 1)
      bb = step(bb, cc, dd, aa, x[14], 13, 1)
      aa = step(aa, bb, cc, dd, x[3], 3, 1)
      dd = step(dd, aa, bb, cc, x[7], 5, 1)
      cc = step(cc, dd, aa, bb, x[11], 9, 1)
      bb = step(bb, cc, dd, aa, x[15], 13, 1)

      # Round 3 (H): shifts 3,9,11,15
      aa = step(aa, bb, cc, dd, x[0], 3, 2)
      dd = step(dd, aa, bb, cc, x[8], 9, 2)
      cc = step(cc, dd, aa, bb, x[4], 11, 2)
      bb = step(bb, cc, dd, aa, x[12], 15, 2)
      aa = step(aa, bb, cc, dd, x[2], 3, 2)
      dd = step(dd, aa, bb, cc, x[10], 9, 2)
      cc = step(cc, dd, aa, bb, x[6], 11, 2)
      bb = step(bb, cc, dd, aa, x[14], 15, 2)
      aa = step(aa, bb, cc, dd, x[1], 3, 2)
      dd = step(dd, aa, bb, cc, x[9], 9, 2)
      cc = step(cc, dd, aa, bb, x[5], 11, 2)
      bb = step(bb, cc, dd, aa, x[13], 15, 2)
      aa = step(aa, bb, cc, dd, x[3], 3, 2)
      dd = step(dd, aa, bb, cc, x[11], 9, 2)
      cc = step(cc, dd, aa, bb, x[7], 11, 2)
      bb = step(bb, cc, dd, aa, x[15], 15, 2)

      a = (a + aa) & MASK
      b = (b + bb) & MASK
      c = (c + cc) & MASK
      d = (d + dd) & MASK
    end

    [a, b, c, d].pack("V4")
  end

  def self.step(target, x, y, z, k, shift, round)
    fn =
      case round
      when 0 then f(x, y, z)
      when 1 then g(x, y, z)
      else h(x, y, z)
      end
    const =
      case round
      when 0 then 0
      when 1 then 0x5A827999
      else 0x6ED9EBA1
      end
    rotl((target + fn + k + const) & MASK, shift)
  end

  def self.f(x, y, z)
    (x & y) | ((~x & z) & MASK)
  end

  def self.g(x, y, z)
    (x & y) | (x & z) | (y & z)
  end

  def self.h(x, y, z)
    x ^ y ^ z
  end

  def self.rotl(value, bits)
    ((value << bits) | (value >> (32 - bits))) & MASK
  end
end
