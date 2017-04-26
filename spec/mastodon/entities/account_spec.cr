require "../../spec_helper"

describe Mastodon::Entities::Account do
  describe "initialize from JSON" do
    subject { Mastodon::Entities::Account.from_json(load_fixture("account")) }
    let(other_account) { Mastodon::Entities::Account.from_json(load_fixture("account")) }

    it "is a Mastodon::Entities::Account" do
      expect(subject).to be_a Mastodon::Entities::Account
    end

    it ".created_at is a Time" do
      expect(subject.created_at).to be_a Time
    end

    it "equals by id" do
      expect(subject).to eq other_account
    end
  end

  describe "initialize from JSON array" do
    subject {  Mastodon::Collection(Mastodon::Entities::Account).from_json(load_fixture("accounts")) }

    it "is a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end

    it ".next_id is equal minimum of ids" do
      expect(subject.next_id).to eq 1
    end

    it ".prev_id is equal maximum of ids" do
      expect(subject.prev_id).to eq 3
    end
  end
end
