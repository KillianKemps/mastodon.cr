require "../../spec_helper"

describe Mastodon::REST do
  describe "Error" do
    it "initialize by string" do
      error = Mastodon::REST::Error.new("some error")
      error.message.should eq "some error"
    end

    it "initialize by HTTP::Client::Response" do
      response = HTTP::Client::Response.new(404)
      error = Mastodon::REST::Error.new(response)
      error.message.should eq "404 Not Found"
    end
  end
end
