require "../../spec_helper"

describe Mastodon::REST do
  describe "Client" do
    it "initialize" do
      client = Mastodon::REST::Client.new(url: "mastodon.cloud")
      client.should be_a Mastodon::REST::Client
      client.url.should eq "mastodon.cloud"
      client.access_token?.should be_nil
    end

    it "initialize with acckess token" do
      client = Mastodon::REST::Client.new(url: "mastodon.cloud", access_token: "TOKEN")
      client.should be_a Mastodon::REST::Client
      client.url.should eq "mastodon.cloud"
      client.access_token?.should be_a OAuth2::AccessToken::Bearer
      client.access_token.access_token.should eq "TOKEN"
    end
  end
end
