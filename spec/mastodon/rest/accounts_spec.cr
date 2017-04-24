require "../../spec_helper"

def account(id)
  stub_get("/api/v1/accounts/#{id}", "account")
  client.account(id)
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

def followers(id, max_id = nil, since_id = nil, limit = 40)
  params = HTTP::Params.build do |param|
    param.add "max_id", "#{max_id}" unless max_id.nil?
    param.add "since_id", "#{since_id}" unless since_id.nil?
    param.add "limit", "#{limit}" if limit != 40 && limit <= 80
  end
  query = "?#{params}" unless params.empty?
  stub_get("/api/v1/accounts/#{id}/followers#{query}", "accounts")
  client.followers(id, max_id, since_id, limit)
end

def following(id, max_id = nil, since_id = nil, limit = 40)
  params = HTTP::Params.build do |param|
    param.add "max_id", "#{max_id}" unless max_id.nil?
    param.add "since_id", "#{since_id}" unless since_id.nil?
    param.add "limit", "#{limit}" if limit != 40 && limit <= 80
  end
  query = "?#{params}" unless params.empty?
  stub_get("/api/v1/accounts/#{id}/following#{query}", "accounts")
  client.following(id, max_id, since_id, limit)
end

def statuses(id, only_media = false, exclude_replies = false, max_id = nil, since_id = nil, limit = 20)
  params = HTTP::Params.build do |param|
    param.add "only_media", "" if only_media
    param.add "exclude_replies", "" if exclude_replies
    param.add "max_id", "#{max_id}" unless max_id.nil?
    param.add "since_id", "#{since_id}" unless since_id.nil?
    param.add "limit", "#{limit}" if limit != 20 && limit <= 40
  end
  stub_get("/api/v1/accounts/#{id}/statuses", "statuses")
  client.statuses(id, only_media, exclude_replies, max_id, since_id, limit)
end

{% for method in {"follow", "unfollow", "block", "unblock", "mute", "unmute"} %}
def {{ method.id }}(id)
  stub_post("/api/v1/accounts/#{id}/{{ method.id }}", "relationship")
  client.{{ method.id }}(id)
end
{% end %}

def relationships(id)
  stub_get("/api/v1/accounts/relationships?id=#{id}", "relationships")
  client.relationships(id)
end

def search_accounts(name, limit = 40)
  params = HTTP::Params.build do |param|
    param.add "q", "#{name}"
    param.add "limit", "#{limit}" if limit != 40 && limit <= 80
  end
  query = "?#{params}" unless params.empty?
  stub_get("/api/v1/accounts/search#{query}", "accounts")
  client.search_accounts(name, limit)
end

describe Mastodon::REST::Client do
  describe ".account(id)" do
    it "Response should be a Mastodon::Entities::Account" do
      account(1).should be_a Mastodon::Entities::Account
    end
  end

  describe ".verify_credentials" do
    it "Response should be a Mastodon::Entities::Account" do
      verify_credentials.should be_a Mastodon::Entities::Account
    end
  end

  describe ".update_credentials(display_name, note, avatar, header)" do
    it "Response should be a Mastodon::Entities::Account" do
      update_credentials("DISPLAY_NAME").should be_a Mastodon::Entities::Account
    end
    it "Expect raise ArgumentError" do
      expect_raises(ArgumentError) { update_credentials }
    end
  end

  describe ".followers(id, max_id, since_id, limit)" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Account)" do
      followers(1).should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe ".following(id, max_id, since_id, limit)" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Account)" do
      following(1).should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe ".statuses(id, only_media, exclude_replies, max_id, since_id, limit)" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Status)" do
      statuses(1).should be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end

  describe ".block(id)" do
    it "Response should be a Mastodon::Entities::Relationship" do
      block(1).should be_a Mastodon::Entities::Relationship
    end
  end

  describe ".unblock(id)" do
    it "Response should be a Mastodon::Entities::Relationship" do
      unblock(1).should be_a Mastodon::Entities::Relationship
    end
  end

  describe ".mute(id)" do
    it "Response should be a Mastodon::Entities::Relationship" do
      mute(1).should be_a Mastodon::Entities::Relationship
    end
  end

  describe ".unmute(id)" do
    it "Response should be a Mastodon::Entities::Relationship" do
      unmute(1).should be_a Mastodon::Entities::Relationship
    end
  end

  describe ".relationships(ids)" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Relationship)" do
      relationships(1).should be_a Mastodon::Collection(Mastodon::Entities::Relationship)
    end
  end

  describe ".search_accounts(name, limit)" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Account)" do
      search_accounts("name", 10).should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end
end
