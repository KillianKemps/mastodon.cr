require "../../spec_helper"

describe Mastodon::Entities::Status do
  subject { Mastodon::Entities::Status.from_json(load_fixture("status")) }

  describe "#from_json" do
    it "is a Mastodon::Entities::Status" do
      expect(subject).to be_a Mastodon::Entities::Status
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

  describe "#==" do
    let(other_status) { Mastodon::Entities::Status.from_json(load_fixture("status")) }
    it "equals by id" do
      expect(subject).to eq other_status
    end
  end
end
