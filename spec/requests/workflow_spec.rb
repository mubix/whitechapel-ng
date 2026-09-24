require "rails_helper"

# End-to-end coverage of the core workflow: index -> upload/search ->
# hash generation -> hash lookup.
RSpec.describe "Whitechapel workflow", type: :request do
  before(:all) { ensure_seed_data! }

  it "serves the landing page" do
    get "/"
    expect(response).to have_http_status(:success)
    expect(response.body).to include("WhiteChapel-NG")
  end

  it "finds generated hashes via hash search" do
    get "/hashes/search", params: { q: "8846f7eaee8fb117ad06bdd830b7586c" }
    expect(response).to have_http_status(:success)
    expect(response.body).to include("Hash not found")

    password = Passwords.create!(cleartext: "password", source: "spec")
    Pwhashes.generate_hashes_from_cleartext("password", password.id)

    get "/hashes/search", params: { q: "8846f7eaee8fb117ad06bdd830b7586c" }
    expect(response).to have_http_status(:success)
    expect(response.body).to include("password")
  end

  it "queues hash generation for unknown cleartext passwords" do
    expect {
      get "/cleartext/search", params: { q: "BrandNewPass1", s: "spec" }
    }.to change(Delayed::Job, :count).by(1)
    expect(response).to redirect_to("/")
  end

  it "queues uploaded wordlists for processing" do
    wordlist = Tempfile.new(["wordlist", ".txt"])
    wordlist.write("AlphaPass1\nBetaPass2\n")
    wordlist.close

    expect {
      post "/upload/upload_wordlist",
           params: { wordlist: Rack::Test::UploadedFile.new(wordlist.path, "text/plain"), source: "spec" }
    }.to change(Delayed::Job, :count).by(1)
    expect(response).to redirect_to("/")
  end

  it "returns the cleartext for a known hash" do
    password = Passwords.create!(cleartext: "Hunt3dPass", source: "spec")
    Pwhashes.generate_hashes_from_cleartext("Hunt3dPass", password.id)

    get "/hashes/cleartext/#{password.id}"
    expect(response).to have_http_status(:success)
    expect(response.body).to include("Hunt3dPass")
  end
end
