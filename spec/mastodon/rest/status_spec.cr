require "../../spec_helper"

def status(id)
  stub_get("/api/v1/statuses/#{id}", "status")
  client.status(id)
end

def create_status(status, in_reply_to_id = nil, media_ids = [] of Int32, sensitive = false, spoiler_text = "", visibility = "")
  forms = HTTP::Params.build do |form|
    form.add "status", "#{status}"
    form.add "in_reply_to_id", "#{in_reply_to_id}" unless in_reply_to_id.nil?
    unless media_ids.empty?
      media_ids.each do |id|
        form.add "media_ids[]", "#{id}"
      end
    end
    form.add "sensitive", "true" if sensitive
    form.add "spoiler_text", "#{spoiler_text}" unless spoiler_text.empty?
    form.add "visibility", "#{visibility}" if ["direct", "private", "unlisted", "public"].includes?(visibility)
  end
  stub_post("/api/v1/statuses", "status", forms)
  client.create_status(status, in_reply_to_id, media_ids, sensitive, spoiler_text, visibility)
end

def delete_status(id)
  WebMock.stub(:delete, "https://#{client.url}/api/v1/statuses/#{id}").
    with(headers: {"Authorization" => "Bearer token"}).
    to_return(body: "{}")
  client.delete_status(id)
end

def card(id)
  stub_get("/api/v1/statuses/#{id}/card", "card")
  client.card(id)
end

def context(id)
  stub_get("/api/v1/statuses/#{id}/context", "context")
  client.context(id)
end

{% for method in {"reblogged_by", "favourited_by"} %}
def {{ method.id }}(id, max_id = nil, since_id = nil, limit = 40)
  params = HTTP::Params.build do |param|
    param.add "max_id", "#{max_id}" unless max_id.nil?
    param.add "since_id", "#{since_id}" unless since_id.nil?
    param.add "limit", "#{limit}" if limit != 40 && limit <= 80
  end
  query = "?#{params}" unless params.empty?
  stub_get("/api/v1/statuses/#{id}/{{ method.id }}#{query}", "accounts")
  client.{{ method.id }}(id, max_id, since_id, limit)
end
{% end %}

{% for method in {"reblog", "unreblog", "favourite", "unfavourite"} %}
def {{ method.id }}(id)
  stub_post("/api/v1/statuses/#{id}/{{ method.id }}", "status")
  client.{{ method.id }}(id)
end
{% end %}

describe Mastodon::REST::Client do
  describe ".status(id)" do
    it "Response should be a Mastodon::Entities::Status" do
      status(1).should be_a Mastodon::Entities::Status
    end
  end

  describe ".create_status(status, in_reply_to_id, media_ids, sensitive, spoiler_text, visibility)" do
    it "Response should be a Mastodon::Entities::Status" do
      create_status("Hello world").should be_a Mastodon::Entities::Status
    end
  end

  describe ".delete_status(id)" do
    it "Response should be no return" do
      delete_status(1).should eq "{}"
    end
  end

  describe ".card(id)" do
    it "Response should be a Mastodon::Entities::Card" do
      card(1).should be_a Mastodon::Entities::Card
    end
  end

  describe ".context(id)" do
    it "Response should be a Mastodon::Entities::Context" do
      context(1).should be_a Mastodon::Entities::Context
    end
  end

  describe ".reblogged_by(id, max_id, since_id, limit)" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Account)" do
      reblogged_by(1).should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe ".favourited_by(id, max_id, since_id, limit)" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Account)" do
      favourited_by(1).should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe ".reblog(id)" do
    it "Response should be a Mastodon::Entities::Status" do
      reblog(1).should be_a Mastodon::Entities::Status
    end
  end

  describe ".unreblog(id)" do
    it "Response should be a Mastodon::Entities::Status" do
      unreblog(1).should be_a Mastodon::Entities::Status
    end
  end

  describe ".favourite(id)" do
    it "Response should be a Mastodon::Entities::Status" do
      favourite(1).should be_a Mastodon::Entities::Status
    end
  end

  describe ".unfavourite(id)" do
    it "Response should be a Mastodon::Entities::Status" do
      unfavourite(1).should be_a Mastodon::Entities::Status
    end
  end
end
