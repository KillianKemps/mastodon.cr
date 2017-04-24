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
      accounts = Array(Mastodon::Entities::Account).from_json(accounts_json)
      accounts.should be_a Array(Mastodon::Entities::Account)
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
  end
end
