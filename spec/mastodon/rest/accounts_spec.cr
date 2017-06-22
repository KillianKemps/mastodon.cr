require "../../spec_helper"

describe Mastodon::REST::Accounts do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#account" do
    before do
      stub_get("/api/v1/accounts/1", "account")
    end
    subject { client.account(1) }
    it "is a Mastodon::Entities::Account" do
      expect(subject).to be_a Mastodon::Entities::Account
    end
  end

  describe "#verify_credentials" do
    before do
      stub_get("/api/v1/accounts/verify_credentials", "account")
    end
    subject { client.verify_credentials }
    it "is a Mastodon::Entities::Account" do
      expect(subject).to be_a Mastodon::Entities::Account
    end
  end

  describe "#update_credentials" do
    before do
      WebMock.stub(:patch, "https://#{client.url}/api/v1/accounts/update_credentials").
        with(headers: default_headers).
        to_return(body: load_fixture("account"))
    end
    subject { client.update_credentials(display_name: "DISPLAY_NAME") }
    it "is a Mastodon::Entities::Account" do
      expect(subject).to be_a Mastodon::Entities::Account
    end

    describe "without parametors" do
      subject { client.update_credentials() }
      it "raise HTTP::Multipart::Error" do
        expect { subject }.to raise_error(HTTP::Multipart::Error)
      end
    end
  end

  describe "#followers" do
    before do
      stub_get("/api/v1/accounts/1/followers", "accounts")
    end
    subject { client.followers(1) }
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe "#following" do
    before do
      stub_get("/api/v1/accounts/1/following", "accounts")
    end
    subject { client.following(1) }
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe "#statuses" do
    before do
      stub_get("/api/v1/accounts/1/statuses", "statuses")
    end
    subject { client.statuses(1) }
    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end

  {% for method in {"follow", "unfollow", "block", "unblock", "mute", "unmute", "mute_boosts", "unmute_boosts"} %}
  describe "#" + "{{ method.id }}" do
    before do
      stub_post("/api/v1/accounts/1/{{ method.id }}", "relationship")
    end
    subject { client.{{ method.id }}(1) }
    it "is a Mastodon::Entities::Relationship" do
      expect(subject).to be_a Mastodon::Entities::Relationship
    end
  end
  {% end %}

  describe "#relationships" do
    before do
      params = HTTP::Params.build do |param|
        param.add "id[]", "1"
      end
      stub_get("/api/v1/accounts/relationships", "relationships", params)
    end
    subject { client.relationships(1) }
    it "is a Mastodon::Collection(Mastodon::Entities::Relationship)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Relationship)
    end
  end

  describe "#search_accounts" do
    before do
      params = HTTP::Params.build do |param|
        param.add "q", "name"
        param.add "limit", "10"
      end
      stub_get("/api/v1/accounts/search", "accounts", params)
    end
    subject { client.search_accounts("name", 10) }
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end
end
