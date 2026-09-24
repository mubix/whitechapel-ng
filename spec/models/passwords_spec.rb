require "rails_helper"

describe Passwords do
  it "keeps cleartext and source unique" do
    expect { Passwords.create!(cleartext: "SpecPass1", source: "spec") }
      .to change(Passwords, :count).by(1)
    expect { Passwords.create(cleartext: "SpecPass1", source: "spec") }
      .not_to change(Passwords, :count)
  end
end
