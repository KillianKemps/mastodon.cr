require "../../spec_helper"

describe Mastodon::Entities::Notification do
  subject { Mastodon::Entities::Notification.from_json(load_fixture("notification")) }

  describe "#from_json" do
    it "is a Mastodon::Entities::Notification" do
      expect(subject).to be_a Mastodon::Entities::Notification
    end
  end

  describe "#created_at" do
    it "is a Time" do
      expect(subject.created_at).to be_a Time
    end
  end

  describe "#account" do
    it "is a Mastodon::Entities::Account" do
      expect(subject.account).to be_a Mastodon::Entities::Account
    end
  end
end
