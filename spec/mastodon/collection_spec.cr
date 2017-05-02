require "../../spec_helper"

describe Mastodon::Collection do
  subject(:accounts) { Mastodon::Collection(Mastodon::Entities::Account).from_json(load_fixture("accounts")) }

  describe "#from_json" do
    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(accounts).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end
  end

  describe "#next_id" do
    it "is equal minimum of ids" do
      expect(accounts.next_id).to eq 1
    end
  end

  describe "#prev_id" do
    it "is equal maximum of ids" do
      expect(accounts.prev_id).to eq 3
    end
  end
end
