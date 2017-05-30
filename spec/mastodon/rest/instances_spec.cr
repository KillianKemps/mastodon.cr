require "../../spec_helper"

describe Mastodon::REST::Instances do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#instance" do
    before do
      stub_get("/api/v1/instance", "instance")
    end
    subject { client.instance }
    it "is a Mastodon::Entities::Instance" do
      expect(subject).to be_a Mastodon::Entities::Instance
    end
  end
end
