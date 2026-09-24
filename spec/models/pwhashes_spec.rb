require "rails_helper"

describe Pwhashes do
  before(:all) { ensure_seed_data! }

  describe ".generate_hashes_from_cleartext" do
    it "generates every supported hash format" do
      password = Passwords.create!(cleartext: "password", source: "spec")
      described_class.generate_hashes_from_cleartext("password", password.id)

      hashes = Pwhashes.where(password_id: password.id)
                        .includes(:type)
                        .index_by { |pwhash| pwhash.type.name }

      expect(hashes).to have_key("lm")
      expect(hashes["lm"].password_hash).to eq("e52cac67419a9a224a3b108f3fa6cb6d")
      expect(hashes["ntlm"].password_hash).to eq("8846f7eaee8fb117ad06bdd830b7586c")
      expect(hashes["ntlmv1"].password_hash).to match(/\A[0-9a-f]{48}\z/)
      expect(hashes["md5"].password_hash).to eq("5f4dcc3b5aa765d61d8327deb882cf99")
      expect(hashes["sha1"].password_hash).to eq("5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8")
      expect(hashes["sha256"].password_hash).to eq("5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8")
      expect(hashes["sha512"].password_hash).to eq("b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86")
      expect(hashes["mysql"].password_hash).to eq("*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19")
    end
  end
end
