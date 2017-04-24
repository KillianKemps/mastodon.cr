require "../../spec_helper"

describe Mastodon::Entities do
  describe "Notification" do
    notification_json = load_fixture("notification")
    notifications_json = load_fixture("notifications")

    it "initialize from JSON" do
      notification = Mastodon::Entities::Notification.from_json(notification_json)
      notification.should be_a Mastodon::Entities::Notification
    end

    it "initialize from JSON array" do
      notifications = Mastodon::Collection(Mastodon::Entities::Notification).from_json(notifications_json)
      notifications.should be_a Mastodon::Collection(Mastodon::Entities::Notification)
    end

    it ".created_at should be a Time" do
      notification = Mastodon::Entities::Notification.from_json(notification_json)
      notification.created_at.should be_a Time
    end

    it ".account should be a Mastodon::Entities::Account" do
      notification = Mastodon::Entities::Notification.from_json(notification_json)
      notification.account.should be_a Mastodon::Entities::Account
    end

    it ".next_id and .prev_id" do
      notifications = Mastodon::Collection(Mastodon::Entities::Notification).from_json(notifications_json)
      notifications.next_id.should eq 1
      notifications.prev_id.should eq 3
    end
  end
end
