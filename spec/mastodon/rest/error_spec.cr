require "../../spec_helper"

describe Mastodon::REST::Error do
  describe "initialize by String" do
    subject { Mastodon::REST::Error.new("some error") }

    it "message" do
      expect(subject.message).to eq "some error"
    end
  end

  describe "initialize by HTTP::Client::Response" do
    subject { Mastodon::REST::Error.new(HTTP::Client::Response.new(404)) }
    it "message" do
      expect(subject.message).to eq "404 Not Found"
    end
  end
end
