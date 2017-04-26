require "../../spec_helper"

describe Mastodon::Entities::Status do
  describe "initialize from JSON" do
    subject { Mastodon::Entities::Status.from_json(load_fixture("status")) }
    let(other_status) { Mastodon::Entities::Status.from_json(load_fixture("status")) }

    it "is a Mastodon::Entities::Status" do
      expect(subject).to be_a Mastodon::Entities::Status
    end

    it ".created_at is a Time" do
      expect(subject.created_at).to be_a Time
    end

    it ".account is a Mastodon::Entities::Account" do
      expect(subject.account).to be_a Mastodon::Entities::Account
    end

    it "equals by id" do
      expect(subject).to eq other_status
    end
  end

  describe "initialize from JSON array" do
    subject { Mastodon::Collection(Mastodon::Entities::Status).from_json(load_fixture("statuses")) }

    it "is a Mastodon::Collection(Mastodon::Entities::Status)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Status)
    end

    it ".next_id and .prev_id" do
      expect(subject.next_id).to eq 1
      expect(subject.prev_id).to eq 3
    end
  end
end
