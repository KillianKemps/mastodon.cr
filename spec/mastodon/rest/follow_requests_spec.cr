require "../../spec_helper"

describe Mastodon::REST::FollowRequests do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#follow_requests" do
    before do
      stub_get("/api/v1/follow_requests", "accounts")
    end
    subject { client.follow_requests }
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe "#authorize_follow_request" do
    before do
      stub_post("/api/v1/follow_requests/1/authorize")
    end
    subject { client.authorize_follow_request(1) }
    it "is no return" do
      expect(subject).to be_nil
    end
  end

  describe "#reject_follow_request" do
    before do
      stub_post("/api/v1/follow_requests/1/reject")
    end
    subject { client.reject_follow_request(1) }
    it "is no return" do
      expect(subject).to be_nil
    end
  end
end
