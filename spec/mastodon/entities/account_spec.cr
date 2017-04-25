require "../../spec_helper"

describe Mastodon::Entities::Account do
  describe "initialize from JSON" do
    subject { Mastodon::Entities::Account.from_json(load_fixture("account")) }
    let(other_account) { Mastodon::Entities::Account.from_json(load_fixture("account")) }

    it "should be a Mastodon::Entities::Account" do
      expect(subject).to be_a Mastodon::Entities::Account
    end

    it ".created_at should be a Time" do
      expect(subject.created_at).to be_a Time
    end

    it "equals by id" do
      expect(subject).to eq other_account
    end
  end

  describe "initialize from JSON array" do
    subject {  Mastodon::Collection(Mastodon::Entities::Account).from_json(load_fixture("accounts")) }

    it "should be a Mastodon::Collection(Mastodon::Entities::Account)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Account)
    end

    it ".next_id and .prev_id" do
      expect(subject.next_id).to eq 1
      expect(subject.prev_id).to eq 3
    end
  end
end
