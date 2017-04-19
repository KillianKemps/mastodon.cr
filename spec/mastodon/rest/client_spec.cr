require "../../spec_helper"

describe Mastodon::REST do
  describe "Client" do
    it "Client should be a Mastodon::REST::Client" do
      Mastodon::REST::Client.new(url: "mastodon.cloud").should be_a Mastodon::REST::Client
    end
  end
end
