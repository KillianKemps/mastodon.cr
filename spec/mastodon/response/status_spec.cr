require "../../spec_helper"

describe Mastodon::Entities do
  describe "Status" do
    status_json = load_fixture("status")
    statuses_json = load_fixture("statuses")

    it "initialize from JSON" do
      status = Mastodon::Entities::Status.from_json(status_json)
      status.should be_a Mastodon::Entities::Status
    end

    it "initialize from JSON array" do
      statuses = Array(Mastodon::Entities::Status).from_json(statuses_json)
      statuses.should be_a Array(Mastodon::Entities::Status)
    end

    it ".created_at should be a Time" do
      status = Mastodon::Entities::Status.from_json(status_json)
      status.created_at.should be_a Time
    end

    it ".account should be a Mastodon::Entities::Account" do
      status = Mastodon::Entities::Status.from_json(status_json)
      status.account.should be_a Mastodon::Entities::Account
    end

    it "equals by id" do
      status = Mastodon::Entities::Status.from_json(status_json)
      other_status = Mastodon::Entities::Status.from_json(status_json)
      status.should eq other_status
    end
  end
end
