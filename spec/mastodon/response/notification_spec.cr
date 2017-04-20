require "../../spec_helper"

describe Mastodon::Response do
  describe "Notification" do
    notification_json = load_fixture("notification")
    notifications_json = load_fixture("notifications")

    it "initialize from JSON" do
      notification = Mastodon::Response::Notification.from_json(notification_json)
      notification.should be_a Mastodon::Response::Notification
    end

    it "initialize from JSON array" do
      notifications = Array(Mastodon::Response::Notification).from_json(notifications_json)
      notifications.should be_a Array(Mastodon::Response::Notification)
    end

    it ".created_at should be a Time" do
      notification = Mastodon::Response::Notification.from_json(notification_json)
      notification.created_at.should be_a Time
    end

    it ".account should be a Mastodon::Response::Account" do
      notification = Mastodon::Response::Notification.from_json(notification_json)
      notification.account.should be_a Mastodon::Response::Account
    end
  end
end
