require "../../spec_helper"

describe Mastodon::Entities do
  describe "Account" do
    account_json = load_fixture("account")
    accounts_json = load_fixture("accounts")

    it "initialize from JSON" do
      account = Mastodon::Entities::Account.from_json(account_json)
      account.should be_a Mastodon::Entities::Account
    end

    it "initialize from JSON array" do
      accounts = Mastodon::Collection(Mastodon::Entities::Account).from_json(accounts_json)
      accounts.should be_a Mastodon::Collection(Mastodon::Entities::Account)
    end

    it ".created_at should be a Time" do
      account = Mastodon::Entities::Account.from_json(account_json)
      account.created_at.should be_a Time
    end

    it "equals by id" do
      account = Mastodon::Entities::Account.from_json(account_json)
      other_account = Mastodon::Entities::Account.from_json(account_json)
      account.should eq other_account
    end

    it ".next_id and .prev_id" do
      accounts = Mastodon::Collection(Mastodon::Entities::Account).from_json(accounts_json)
      accounts.next_id.should eq 1
      accounts.prev_id.should eq 3
    end
  end
end
