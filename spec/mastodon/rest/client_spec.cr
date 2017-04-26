require "../../spec_helper"

describe Mastodon::REST::Client do
  subject { Mastodon::REST::Client.new(url: "example.com") }

  it "is a Mastodon::REST::Client" do
    expect(subject).to be_a Mastodon::REST::Client
  end

  it ".user_agent is equal `mastodon.cr/<version>`" do
    expect(subject.user_agent).to eq "mastodon.cr/#{Mastodon::VERSION}"
  end

  describe "initialize without acckess token" do
    subject { Mastodon::REST::Client.new(url: "example.com") }

    it ".access_token is nil" do
      expect(subject.access_token?).to be_nil
    end
  end

  describe "initialize with acckess token" do
    subject { Mastodon::REST::Client.new(url: "example.com", access_token: "TOKEN") }

    it ".access_token is a OAuth2::AccessToken::Bearer" do
      expect(subject.access_token?).to be_a OAuth2::AccessToken::Bearer
      expect(subject.access_token.access_token).to eq "TOKEN"
    end
  end
end
