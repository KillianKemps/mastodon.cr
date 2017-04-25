require "../../spec_helper"

describe Mastodon::REST::Client do
  describe "initialize" do
    subject { Mastodon::REST::Client.new(url: "example.com") }

    it "should be a Mastodon::REST::Client" do
      expect(subject).to be_a Mastodon::REST::Client
    end

    it "parametors" do
      expect(subject.url).to eq "example.com"
      expect(subject.access_token?).to be_nil
    end
  end

  describe "initialize with acckess token" do
    subject { Mastodon::REST::Client.new(url: "example.com", access_token: "TOKEN") }

    it "should be a Mastodon::REST::Client" do
      expect(subject).to be_a Mastodon::REST::Client
    end

    it "parametors" do
      expect(subject.url).to eq "example.com"
      expect(subject.access_token?).to be_a OAuth2::AccessToken::Bearer
      expect(subject.access_token.access_token).to eq "TOKEN"
    end
  end
end
