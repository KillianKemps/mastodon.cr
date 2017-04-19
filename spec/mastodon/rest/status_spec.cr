require "../../spec_helper"

def status
  stub_get("/api/v1/statuses/1", "status")
  client.status(1)
end

def create_status
  stub_post("/api/v1/statuses", "status", "status=Hello+world")
  client.create_status("Hello world")
end

def delete_status
  WebMock.stub(:delete, "https://#{client.url}/api/v1/statuses/1").
    with(headers: {"Authorization" => "Bearer token"}).
    to_return(body: "{}")
  client.delete_status(1)
end

def card
  stub_get("/api/v1/statuses/1/card", "card")
  client.card(1)
end

def context
  stub_get("/api/v1/statuses/1/context", "context")
  client.context(1)
end

{% for method in {"reblogged_by", "favourited_by"} %}
def {{ method.id }}
  stub_post("/api/v1/statuses/1/{{ method.id }}", "accounts")
  client.{{ method.id }}(1)
end
{% end %}

{% for method in {"reblog", "unreblog", "favourite", "unfavourite"} %}
def {{ method.id }}
  stub_post("/api/v1/statuses/1/{{ method.id }}", "status")
  client.{{ method.id }}(1)
end
{% end %}

describe Mastodon::REST::Client do
  describe ".status" do
    it "Response should be a Mastodon::Response::Status" do
      status.should be_a Mastodon::Response::Status
    end
  end

  describe ".create_status(status, in_reply_to_id, media_ids, sensitive, spoiler_text, visibility)" do
    it "Response should be a Mastodon::Response::Status" do
      create_status.should be_a Mastodon::Response::Status
    end
  end

  describe ".delete_status(id)" do
    it "Response should be no return" do
      delete_status.should eq "{}"
    end
  end

  describe ".card(id)" do
    it "Response should be a Mastodon::Response::Card" do
      card.should be_a Mastodon::Response::Card
    end
  end

  describe ".context(id)" do
    it "Response should be a Mastodon::Response::Context" do
      context.should be_a Mastodon::Response::Context
    end
  end

  describe ".reblogged_by(id)" do
    it "Response should be a Array(Mastodon::Response::Account)" do
      reblogged_by.should be_a Array(Mastodon::Response::Account)
    end
  end

  describe ".favourited_by(id)" do
    it "Response should be a Array(Mastodon::Response::Account)" do
      favourited_by.should be_a Array(Mastodon::Response::Account)
    end
  end

  describe ".reblog(id)" do
    it "Response should be a Mastodon::Response::Status" do
      reblog.should be_a Mastodon::Response::Status
    end
  end

  describe ".unreblog(id)" do
    it "Response should be a Mastodon::Response::Status" do
      unreblog.should be_a Mastodon::Response::Status
    end
  end

  describe ".favourite(id)" do
    it "Response should be a Mastodon::Response::Status" do
      favourite.should be_a Mastodon::Response::Status
    end
  end

  describe ".unfavourite(id)" do
    it "Response should be a Mastodon::Response::Status" do
      unfavourite.should be_a Mastodon::Response::Status
    end
  end
end
