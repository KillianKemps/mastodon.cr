require "../../spec_helper"

describe Mastodon::REST::Client do
  describe "#new" do
    describe "without acckess token" do
      subject { Mastodon::REST::Client.new(url: "example.com") }
      it "is a Mastodon::REST::Client" do
        expect(subject).to be_a Mastodon::REST::Client
      end
      describe "#access_token" do
        it "is nil" do
          expect(subject.access_token?).to be_nil
        end
      end
    end

    describe "with access token string" do
      subject { Mastodon::REST::Client.new(url: "example.com", access_token: "TOKEN") }
      it "is a Mastodon::REST::Client" do
        expect(subject).to be_a Mastodon::REST::Client
      end
      describe "#access_token" do
        it "is a OAuth2::AccessToken::Bearer" do
          expect(subject.access_token?).to be_a OAuth2::AccessToken::Bearer
          expect(subject.access_token.access_token).to eq "TOKEN"
        end
      end
    end

    describe "with access token" do
      subject {
        bearer_token = OAuth2::AccessToken::Bearer.new(access_token: "TOKEN", expires_in: nil)
        Mastodon::REST::Client.new(url: "example.com", access_token: bearer_token)
      }
      it "is a Mastodon::REST::Client" do
        expect(subject).to be_a Mastodon::REST::Client
      end
      describe "#access_token" do
        it "is a OAuth2::AccessToken::Bearer" do
          expect(subject.access_token?).to be_a OAuth2::AccessToken::Bearer
          expect(subject.access_token.access_token).to eq "TOKEN"
        end
      end
    end
  end

  describe "#user_agent" do
    subject { Mastodon::REST::Client.new(url: "example.com") }
    it "is equal `mastodon.cr/<version>`" do
      expect(subject.user_agent).to eq "mastodon.cr/#{Mastodon::VERSION}"
    end
  end

  describe "#get" do
    let(client) { Mastodon::REST::Client.new("example.com", "token") }

    describe "without parametors" do
      before do
        WebMock.stub(:get, "https://example.com/get").to_return(body: "ok")
      end
      subject { client.get("/get") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors string" do
      before do
        WebMock.stub(:get, "https://example.com/get").with(query: { "param1" => "1", "param2" => "2" }).to_return(body: "ok")
      end
      subject { client.get("/get", "param1=1&param2=2") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors hash" do
      before do
        WebMock.stub(:get, "https://example.com/get").with(query: { "param1" => "1", "param2" => "2" }).to_return(body: "ok")
      end
      subject { client.get("/get", { "param1" => "1", "param2" => "2" }) }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end
  end

  describe "#post" do
    let(client) { Mastodon::REST::Client.new("example.com", "token") }

    describe "without parametors" do
      before do
        WebMock.stub(:post, "https://example.com/post").to_return(body: "ok")
      end
      subject { client.post("/post") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors string" do
      before do
        WebMock.stub(:post, "https://example.com/post").with(body: "param1=1&param2=2").to_return(body: "ok")
      end
      subject { client.post("/post", "param1=1&param2=2") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors hash" do
      before do
        WebMock.stub(:post, "https://example.com/post").with(body: "param1=1&param2=2").to_return(body: "ok")
      end
      subject { client.post("/post", { "param1" => "1", "param2" => "2" }) }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end
  end

  describe "#patch" do
    let(client) { Mastodon::REST::Client.new("example.com", "token") }

    describe "without parametors" do
      before do
        WebMock.stub(:patch, "https://example.com/patch").to_return(body: "ok")
      end
      subject { client.patch("/patch") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors string" do
      before do
        WebMock.stub(:patch, "https://example.com/patch").with(body: "param1=1&param2=2").to_return(body: "ok")
      end
      subject { client.patch("/patch", "param1=1&param2=2") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors hash" do
      before do
        WebMock.stub(:patch, "https://example.com/patch").with(body: "param1=1&param2=2").to_return(body: "ok")
      end
      subject { client.patch("/patch", { "param1" => "1", "param2" => "2" }) }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end
  end

  describe "#delete" do
    let(client) { Mastodon::REST::Client.new("example.com", "token") }
    before do
      WebMock.stub(:delete, "https://example.com/delete").to_return(body: "ok")
    end
    subject { client.delete("/delete") }
    it "request success" do
      expect(subject).to eq "ok"
    end
  end
end
