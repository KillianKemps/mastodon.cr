require "../../spec_helper"

describe Mastodon::REST::Apps do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe ".apps" do
    before do
      forms = HTTP::Params.build do |form|
        form.add "client_name", "CLIENT_NAME"
        form.add "redirect_uris", "urn:ietf:wg:oauth:2.0:oob"
        form.add "scopes", "read write follow"
        form.add "website",  ""
      end
      stub_post("/api/v1/apps", "apps", forms)
    end
    subject { client.apps("CLIENT_NAME", redirect_uris: "urn:ietf:wg:oauth:2.0:oob", scopes: "read write follow", website: "") }
    it "is a Mastodon::Entities::Auth::App" do
      expect(subject).to be_a Mastodon::Entities::Auth::App
    end
  end
end
