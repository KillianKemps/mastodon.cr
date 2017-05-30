require "../../spec_helper"

describe Mastodon::REST::Follows do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#follows" do
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
end
