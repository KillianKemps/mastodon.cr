require "../../spec_helper"

def account
  stub_get("/api/v1/accounts/1", "account")
  client.account(1)
end

def verify_credentials
  stub_get("/api/v1/accounts/verify_credentials", "account")
  client.verify_credentials
end

def update_credentials(display_name = "", note = "", avatar = "", header = "")
  forms = HTTP::Params.build do |form|
    form.add "display_name", "#{display_name}" unless display_name.empty?
    form.add "note", "#{note}" unless note.empty?
    form.add "avatar", Mastodon::Utils::Image.base64_encode(avatar) unless avatar.empty?
    form.add "header",  Mastodon::Utils::Image.base64_encode(avatar) unless header.empty?
  end
  WebMock.stub(:patch, "https://#{client.url}/api/v1/accounts/update_credentials").
    with(body: forms, headers: {"Authorization" => "Bearer token"}).
    to_return(body: load_fixture("account"))
  client.update_credentials(display_name, note, avatar, header)
end

{% for method in {"followers", "following"} %}
def {{ method.id }}
  stub_get("/api/v1/accounts/1/{{ method.id }}", "accounts")
  client.{{ method.id }}(1)
end
{% end %}

def statuses
  stub_get("/api/v1/accounts/1/statuses", "statuses")
  client.statuses(1)
end

{% for method in {"follow", "unfollow", "block", "unblock", "mute", "unmute"} %}
def account_{{ method.id }}
  stub_post("/api/v1/accounts/1/{{ method.id }}", "relationship")
  client.account_{{ method.id }}(1)
end
{% end %}

def relationships
  stub_get("/api/v1/accounts/relationships?id=1", "relationships")
  client.relationships(1)
end

def search_accounts
  stub_get("/api/v1/accounts/search?q=name&limit=10", "accounts")
  client.search_accounts("name", 10)
end

describe Mastodon::REST::Client do
  describe ".account(id)" do
    it "Response should be a Mastodon::Response::Account" do
      account.should be_a Mastodon::Response::Account
    end
  end

  describe ".verify_credentials" do
    it "Response should be a Mastodon::Response::Account" do
      verify_credentials.should be_a Mastodon::Response::Account
    end
  end

  describe ".update_credentials(display_name, note, avatar, header)" do
    it "Response should be a Mastodon::Response::Account" do
      update_credentials("DISPLAY_NAME").should be_a Mastodon::Response::Account
    end
    it "Expect raise ArgumentError" do
      expect_raises(ArgumentError) { update_credentials }
    end
  end

  describe ".followers(id)" do
    it "Response should be a Array(Mastodon::Response::Account)" do
      followers.should be_a Array(Mastodon::Response::Account)
    end
  end

  describe ".following(id)" do
    it "Response should be a Array(Mastodon::Response::Account)" do
      following.should be_a Array(Mastodon::Response::Account)
    end
  end

  describe ".statuses(id)" do
    it "Response should be a Array(Mastodon::Response::Status)" do
      statuses.should be_a Array(Mastodon::Response::Status)
    end
  end

  describe ".block" do
    it "Response should be a Mastodon::Response::Account" do
      block.should be_a Mastodon::Response::Account
    end
  end

  describe ".unblock" do
    it "Response should be a Mastodon::Response::Account" do
      unblock.should be_a Mastodon::Response::Account
    end
  end

  describe ".mute" do
    it "Response should be a Mastodon::Response::Account" do
      mute.should be_a Mastodon::Response::Account
    end
  end

  describe ".unmute" do
    it "Response should be a Mastodon::Response::Account" do
      unmute.should be_a Mastodon::Response::Account
    end
  end

  describe ".relationships(id)" do
    it "Response should be a Array(Mastodon::Response::Relationship)" do
      relationships.should be_a Array(Mastodon::Response::Relationship)
    end
  end

  describe ".search_accounts(name, limit)" do
    it "Response should be a Array(Mastodon::Response::Account)" do
      search_accounts.should be_a Array(Mastodon::Response::Account)
    end
  end
end
