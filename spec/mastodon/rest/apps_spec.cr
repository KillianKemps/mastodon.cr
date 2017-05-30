require "../../spec_helper"

describe Mastodon::REST::Apps do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#apps" do
    before do
      stub_post("/api/v1/apps", "apps", {
        "client_name" => "CLIENT_NAME",
        "redirect_uris" => "urn:ietf:wg:oauth:2.0:oob",
        "scopes" => "read write follow",
        "website" => ""
      })
    end
    subject { client.apps("CLIENT_NAME", redirect_uris: "urn:ietf:wg:oauth:2.0:oob", scopes: "read write follow", website: "") }
    it "is a Mastodon::Entities::Auth::App" do
      expect(subject).to be_a Mastodon::Entities::Auth::App
    end
  end
end
