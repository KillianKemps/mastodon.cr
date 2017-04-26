require "../../spec_helper"

describe Mastodon::REST::Miscellaneous do
  describe ".blocks" do
    before do
      stub_get("/api/v1/blocks", "accounts")
    end
    subject { client.blocks }
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe ".favourites" do
    before do
      stub_get("/api/v1/favourites", "statuses")
    end
    subject { client.favourites }
    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end

  describe ".follow_requests" do
    before do
      stub_get("/api/v1/follow_requests", "accounts")
    end
    subject { client.follow_requests }
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe ".authorize_follow_request" do
    before do
      stub_post_no_return("/api/v1/follow_requests/1/authorize")
    end
    subject { client.authorize_follow_request(1) }
    it "is no return" do
      expect(subject).to be_nil
    end
  end

  describe ".reject_follow_request" do
    before do
      stub_post_no_return("/api/v1/follow_requests/1/reject")
    end
    subject { client.reject_follow_request(1) }
    it "is no return" do
      expect(subject).to be_nil
    end
  end

  describe ".follows(username)" do
    before do
      forms = HTTP::Params.build do |form|
        form.add "uri", "user@domain"
      end
      stub_post("/api/v1/follows", "account", forms)
    end
    subject { client.follows("user@domain") }
    it "is a Mastodon::Entities::Account" do
      expect(subject).to be_a Mastodon::Entities::Account
    end
  end

  describe ".instance" do
    before do
      stub_get("/api/v1/instance", "instance")
    end
    subject { client.instance }
    it "is a Mastodon::Entities::Instance" do
      expect(subject).to be_a Mastodon::Entities::Instance
    end
  end

  describe ".mutes" do
    before do
      stub_get("/api/v1/mutes", "accounts")
    end
    subject { client.mutes }
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe ".reports" do
    before do
      stub_get("/api/v1/reports", "reports")
    end
    subject { client.reports }
    it "is a Mastodon::Collection(Mastodon::Entities::Report)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Report)
    end
  end

  describe ".report(account_id, status_ids, comment)" do
    before do
      forms = HTTP::Params.build do |form|
        form.add "account_id", "1"
        form.add "status_ids[]", "1"
        form.add "status_ids[]", "2"
        form.add "status_ids[]", "3"
        form.add "comment", ""
      end
      stub_post("/api/v1/reports", "report", forms)
    end
    subject { client.report(1, [1, 2, 3], "") }
    it "is a Mastodon::Entities::Report" do
      expect(subject).to be_a Mastodon::Entities::Report
    end
  end

  describe ".search(query, resolve)" do
    before do
      params = HTTP::Params.build do |param|
        param.add "q", "QUERY"
      end
      stub_get("/api/v1/search", "results", params)
    end
    subject { client.search("QUERY") }
    it "is a Mastodon::Entities::Results" do
      expect(subject).to be_a Mastodon::Entities::Results
    end
  end
end
