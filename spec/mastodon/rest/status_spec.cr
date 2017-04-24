require "../../spec_helper"

def status(id)
  stub_get("/api/v1/statuses/#{id}", "status")
  client.status(id)
end

def create_status(status)
  forms = HTTP::Params.build do |form|
    form.add "status", status
  end
  stub_post("/api/v1/statuses", "status", forms)
  client.create_status(status)
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
def {{ method.id }}(id)
  stub_post("/api/v1/statuses/#{id}/{{ method.id }}", "accounts")
  client.{{ method.id }}(id)
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

  describe ".reblogged_by(id)" do
    it "Response should be a Array(Mastodon::Entities::Account)" do
      reblogged_by(1).should be_a Array(Mastodon::Entities::Account)
    end
  end

  describe ".favourited_by(id)" do
    it "Response should be a Array(Mastodon::Entities::Account)" do
      favourited_by(1).should be_a Array(Mastodon::Entities::Account)
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
