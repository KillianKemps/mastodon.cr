require "../../spec_helper"

describe Mastodon::REST::Timelines do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#timeline_home" do
    before do
      stub_get("/api/v1/timelines/home", "statuses")
    end
    subject { client.timeline_home }
    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end

  describe "#timeline_public" do
    before do
      stub_get("/api/v1/timelines/public", "statuses")
    end
    subject { client.timeline_public }
    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end

  describe "#timeline_tag" do
    before do
      stub_get("/api/v1/timelines/tag/hashtag", "statuses")
    end
    subject { client.timeline_tag("hashtag") }
    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end
end
