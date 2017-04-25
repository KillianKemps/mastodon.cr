require "../../spec_helper"

def apps
  forms = HTTP::Params.build do |form|
    form.add "client_name", "CLIENT_NAME"
    form.add "redirect_uris", "urn:ietf:wg:oauth:2.0:oob"
    form.add "scopes", "read write follow"
    form.add "website",  ""
  end
  stub_post("/api/v1/apps", "apps", forms)
  client.apps("CLIENT_NAME", redirect_uris: "urn:ietf:wg:oauth:2.0:oob", scopes: "read write follow", website: "")
end

describe Mastodon::REST::Client do
  describe ".apps" do
    it "Response should be a Mastodon::Entities::Auth::App" do
      apps.should be_a Mastodon::Entities::Auth::App
    end
  end
end
