require "../../spec_helper"

describe Mastodon::REST::DomainBlocks do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#domain_blocks" do
    before do
      stub_get("/api/v1/domain_blocks", "domain_blocks")
    end
    subject { client.domain_blocks }
    it "is a Array(String)" do
      expect(subject).to be_a Array(String)
    end
  end

  describe "#block_domain" do
    before do
      forms = HTTP::Params.build do |form|
        form.add "domain", "some.domain"
      end
      stub_post("/api/v1/domain_blocks", "domain_blocks", forms)
    end
    subject { client.block_domain("some.domain") }
    it "is a nil" do
      expect(subject).to be_nil
    end
  end

  describe "#unblock_domain" do
    before do
      forms = HTTP::Params.build do |form|
        form.add "domain", "some.domain"
      end
      WebMock.stub(:delete, "https://#{client.url}/api/v1/domain_blocks").
        with(body: forms, headers: default_headers).
        to_return(body: "{}")
    end
    subject { client.unblock_domain("some.domain") }
    it "is a nil" do
      expect(subject).to be_nil
    end
  end
end
