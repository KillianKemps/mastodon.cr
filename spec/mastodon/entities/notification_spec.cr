require "../../spec_helper"

describe Mastodon::Entities::Notification do
  describe "initialize from JSON" do
    subject { Mastodon::Entities::Notification.from_json(load_fixture("notification")) }

    it "is a Mastodon::Entities::Notification" do
      expect(subject).to be_a Mastodon::Entities::Notification
    end

    it ".created_at is a Time" do
      expect(subject.created_at).to be_a Time
    end

    it ".account is a Mastodon::Entities::Account" do
      expect(subject.account).to be_a Mastodon::Entities::Account
    end
  end

  describe "initialize from JSON array" do
    subject {  Mastodon::Collection(Mastodon::Entities::Notification).from_json(load_fixture("notifications")) }

    it "is a Mastodon::Collection(Mastodon::Entities::Notification)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Notification)
    end

    it ".next_id is equal minimum of ids" do
      expect(subject.next_id).to eq 1
    end

    it ".prev_id is equal maximum of ids" do
      expect(subject.prev_id).to eq 3
    end
  end
end
