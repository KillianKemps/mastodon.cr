require "../../spec_helper"

def favourites
  stub_get("/api/v1/favourites", "statuses")
  client.favourites
end

def blocks
  stub_get("/api/v1/blocks", "accounts")
  client.blocks
end

def follow_requests
  stub_get("/api/v1/follow_requests", "accounts")
  client.follow_requests
end

def authorize_follow_request(id)
  stub_post_no_return("/api/v1/follow_requests/#{id}/authorize")
  client.authorize_follow_request(id)
end

def reject_follow_request(id)
  stub_post_no_return("/api/v1/follow_requests/#{id}/reject")
  client.reject_follow_request(id)
end

def follows(username)
  forms = HTTP::Params.build do |form|
    form.add "uri", username
  end
  stub_post("/api/v1/follows", "account", forms)
  client.follows(username)
end

def instance
  stub_get("/api/v1/instance", "instance")
  client.instance
end

def mutes
  stub_get("/api/v1/mutes", "accounts")
  client.mutes
end

def reports
  stub_get("/api/v1/reports", "reports")
  client.reports
end

def report
  forms = HTTP::Params.build do |form|
    form.add "account_id", "1"
    form.add "status_ids[]", "1"
    form.add "status_ids[]", "2"
    form.add "status_ids[]",  "3"
    form.add "comment",  ""
  end
  stub_post("/api/v1/reports", "report", forms)
  client.report(1, [1, 2, 3])
end

describe Mastodon::REST::Client do
  describe ".blocks" do
    it "Response should be a Array(Mastodon::Response::Account)" do
      blocks.should be_a Array(Mastodon::Response::Account)
    end
  end

  describe ".favourites" do
    it "Response should be a Array(Mastodon::Response::Status)" do
      favourites.should be_a Array(Mastodon::Response::Status)
    end
  end

  describe ".follow_requests" do
    it "Response should be a Array(Mastodon::Response::Account)" do
      follow_requests.should be_a Array(Mastodon::Response::Account)
    end
  end

  describe ".authorize_follow_request" do
    it "Response should be no return" do
      authorize_follow_request(1).should be "{}"
    end
  end

  describe ".reject_follow_request" do
    it "Response should be no return" do
      reject_follow_request(1).should be "{}"
    end
  end

  describe ".follows(username)" do
    it "Response should be a Mastodon::Response::Account" do
      follows("user@domain").should be_a Mastodon::Response::Account
    end
  end

  describe ".instance" do
    it "Response should be a Mastodon::Response::Instance" do
      instance.should be_a Mastodon::Response::Instance
    end
  end

  describe ".mutes" do
    it "Response should be a Array(Mastodon::Response::Account)" do
      mutes.should be_a Array(Mastodon::Response::Account)
    end
  end

  describe ".reports" do
    it "Response should be a Array(Mastodon::Response::Report)" do
      reports.should be_a Array(Mastodon::Response::Report)
    end
  end

  describe ".report(account_id, status_ids, comment)" do
    it "Response should be a Mastodon::Response::Report" do
      report.should be_a Mastodon::Response::Report
    end
  end
end
