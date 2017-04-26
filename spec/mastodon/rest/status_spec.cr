require "../../spec_helper"

describe Mastodon::REST::Statuses do
  describe ".status(id)" do
    before do
      stub_get("/api/v1/statuses/1", "status")
    end
    subject { client.status(1) }
    it "is a Mastodon::Entities::Status" do
      expect(subject).to be_a Mastodon::Entities::Status
    end
  end

  describe ".create_status(status, in_reply_to_id, media_ids, sensitive, spoiler_text, visibility)" do
    before do
      forms = HTTP::Params.build do |form|
        form.add "status", "Hello world"
      end
      stub_post("/api/v1/statuses", "status", forms)
    end
    subject { client.create_status("Hello world") }
    it "is a Mastodon::Entities::Status" do
      expect(subject).to be_a Mastodon::Entities::Status
    end
  end

  describe ".delete_status(id)" do
    before do
      WebMock.stub(:delete, "https://#{client.url}/api/v1/statuses/1").
        with(headers: {"Authorization" => "Bearer token"}).
        to_return(body: "{}")
    end
    subject { client.delete_status(1) }
    it "is no return" do
      expect(subject).to be_nil
    end
  end

  describe ".card(id)" do
    before do
      stub_get("/api/v1/statuses/1/card", "card")
    end
    subject { client.card(1) }
    it "is a Mastodon::Entities::Card" do
      expect(subject).to be_a Mastodon::Entities::Card
    end
  end

  describe ".context(id)" do
    before do
      stub_get("/api/v1/statuses/1/context", "context")
    end
    subject { client.context(1) }
    it "is a Mastodon::Entities::Context" do
      expect(subject).to be_a Mastodon::Entities::Context
    end
  end

  {% for method in {"reblogged_by", "favourited_by"} %}
  describe ".{{ method.id }}(id, max_id, since_id, limit)" do
    before do
      stub_get("/api/v1/statuses/1/{{ method.id }}", "accounts")
    end
    subject { client.{{ method.id }}(1) }
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end
  {% end %}


  {% for method in {"reblog", "unreblog", "favourite", "unfavourite"} %}
  describe ".{{ method.id }}(id)" do
    before do
      stub_post("/api/v1/statuses/1/{{ method.id }}", "status")
    end
    subject { client.{{ method.id }}(1) }
    it "is a Mastodon::Entities::Status" do
      expect(subject).to be_a Mastodon::Entities::Status
    end
  end
  {% end %}
end
