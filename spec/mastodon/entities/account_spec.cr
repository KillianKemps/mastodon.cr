require "../../spec_helper"

describe Mastodon::Entities::Account do
  subject { Mastodon::Entities::Account.from_json(load_fixture("account")) }

  describe "#from_json" do
    it "is a Mastodon::Entities::Account" do
      expect(subject).to be_a Mastodon::Entities::Account
    end
  end

  describe "#created_at" do
    it "is a Time" do
      expect(subject.created_at).to be_a Time
    end
  end

  describe "#==" do
    let(other_account) { Mastodon::Entities::Account.from_json(load_fixture("account")) }
    it "equals by id" do
      expect(subject).to eq other_account
    end
  end
end
