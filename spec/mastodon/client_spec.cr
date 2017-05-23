require "../spec_helper"

describe Mastodon::Client do
  describe "#new" do
    subject { Mastodon::Client.new(url: "example.com") }
    it "is a Mastodon::Client" do
      expect(subject).to be_a Mastodon::Client
    end

    describe "without acckess token" do
      subject { Mastodon::Client.new(url: "example.com") }
      describe "#access_token" do
        it "is nil" do
          expect(subject.access_token?).to be_nil
        end
      end
    end

    describe "with access token string" do
      subject { Mastodon::Client.new(url: "example.com", access_token: "TOKEN") }
      describe "#access_token" do
        it "is a OAuth2::AccessToken::Bearer" do
          expect(subject.access_token?).to be_a OAuth2::AccessToken::Bearer
          expect(subject.access_token.access_token).to eq "TOKEN"
        end
      end
    end

    describe "with access token object" do
      subject {
        bearer_token = OAuth2::AccessToken::Bearer.new(access_token: "TOKEN", expires_in: nil)
        Mastodon::Client.new(url: "example.com", access_token: bearer_token)
      }
      describe "#access_token" do
        it "is a OAuth2::AccessToken::Bearer" do
          expect(subject.access_token?).to be_a OAuth2::AccessToken::Bearer
          expect(subject.access_token.access_token).to eq "TOKEN"
        end
      end
    end
  end

  describe "#user_agent" do
    subject { Mastodon::Client.new(url: "example.com") }
    it "is equal `mastodon.cr/<version>`" do
      expect(subject.user_agent).to eq "mastodon.cr/#{Mastodon::VERSION}"
    end
  end
end
