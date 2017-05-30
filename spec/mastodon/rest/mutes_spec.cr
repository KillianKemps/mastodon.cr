require "../../spec_helper"

describe Mastodon::REST::Mutes do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#mutes" do
    before do
      stub_get("/api/v1/mutes", "accounts")
    end
    subject { client.mutes }
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end
end
