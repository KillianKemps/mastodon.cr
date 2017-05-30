require "../../spec_helper"

describe Mastodon::REST::Client do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#get" do
    describe "without parametors" do
      before do
        WebMock.stub(:get, "https://example.com/get").
          to_return(body: "ok")
      end
      subject { client.get("/get") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors string" do
      before do
        WebMock.stub(:get, "https://example.com/get").
          with(query: { "param1" => "1", "param2" => "2" }).
          to_return(body: "ok")
      end
      subject { client.get("/get", "param1=1&param2=2") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors hash" do
      before do
        WebMock.stub(:get, "https://example.com/get").
          with(query: { "param1" => "1", "param2" => "2" }).
          to_return(body: "ok")
      end
      subject { client.get("/get", { "param1" => "1", "param2" => "2" }) }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end
  end

  describe "#post" do
    describe "without parametors" do
      before do
        WebMock.stub(:post, "https://example.com/post").
          to_return(body: "ok")
      end
      subject { client.post("/post") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors string" do
      before do
        WebMock.stub(:post, "https://example.com/post").
          with(body: "param1=1&param2=2").
          to_return(body: "ok")
      end
      subject { client.post("/post", "param1=1&param2=2") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors hash" do
      before do
        WebMock.stub(:post, "https://example.com/post").
          with(body: "param1=1&param2=2").
          to_return(body: "ok")
      end
      subject { client.post("/post", { "param1" => "1", "param2" => "2" }) }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end
  end

  describe "#patch" do
    describe "without parametors" do
      before do
        WebMock.stub(:patch, "https://example.com/patch").
          to_return(body: "ok")
      end
      subject { client.patch("/patch") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors string" do
      before do
        WebMock.stub(:patch, "https://example.com/patch").
          with(body: "param1=1&param2=2").
          to_return(body: "ok")
      end
      subject { client.patch("/patch", "param1=1&param2=2") }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end

    describe "with parametors hash" do
      before do
        WebMock.stub(:patch, "https://example.com/patch").
          with(body: "param1=1&param2=2").to_return(body: "ok")
      end
      subject { client.patch("/patch", { "param1" => "1", "param2" => "2" }) }
      it "request success" do
        expect(subject).to eq "ok"
      end
    end
  end

  describe "#delete" do
    before do
      WebMock.stub(:delete, "https://example.com/delete").
        to_return(body: "ok")
    end
    subject { client.delete("/delete") }
    it "request success" do
      expect(subject).to eq "ok"
    end
  end
end
