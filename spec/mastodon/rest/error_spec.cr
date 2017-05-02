require "../../spec_helper"

describe Mastodon::REST::Error do
  subject { Mastodon::REST::Error.new(HTTP::Client::Response.new(404)) }

  describe "#message" do
    it "is equal HTTP status code and message" do
      expect(subject.message).to eq "404 Not Found"
    end
  end
end
