require "../../spec_helper"

describe Mastodon::REST::Search do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#search" do
    describe "with keyword" do
      before do
        params = HTTP::Params.build do |param|
          param.add "q", "QUERY"
        end
        stub_get("/api/v1/search", "results", params)
      end
      subject { client.search("QUERY") }
      it "is a Mastodon::Entities::Results" do
        expect(subject).to be_a Mastodon::Entities::Results
      end
    end

    describe "with account URL" do
      before do
        params = HTTP::Params.build do |param|
          param.add "q", "https://example.com/@USER"
        end
        stub_get("/api/v1/search", "results_account", params)
      end
      subject { client.search("https://example.com/@USER") }
      it "is a Mastodon::Entities::Results" do
        expect(subject).to be_a Mastodon::Entities::Results
      end
    end

    describe "with status URL" do
      before do
        params = HTTP::Params.build do |param|
          param.add "q", "https://example.com/@USER/1"
        end
        stub_get("/api/v1/search", "results_status", params)
      end
      subject { client.search("https://example.com/@USER/1") }
      it "is a Mastodon::Entities::Results" do
        expect(subject).to be_a Mastodon::Entities::Results
      end
    end
  end
end
