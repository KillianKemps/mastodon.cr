require "../../spec_helper"

describe Mastodon::REST::Favourites do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#favourites" do
    before do
      stub_get("/api/v1/favourites", "statuses")
    end
    subject { client.favourites }
    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end
end
