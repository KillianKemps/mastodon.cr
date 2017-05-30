require "../../spec_helper"

describe Mastodon::REST::Blocks do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#blocks" do
    before do
      stub_get("/api/v1/blocks", "accounts")
    end
    subject { client.blocks }
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end
end
