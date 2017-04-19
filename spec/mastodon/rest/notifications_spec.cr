require "../../spec_helper"

def notifications
  stub_get("/api/v1/notifications", "notifications")
  client.notifications
end

def notification
  stub_get("/api/v1/notifications/1", "notification")
  client.notification(1)
end

describe Mastodon::REST::Client do
  describe ".notifications" do
    it "Response should be a Array(Mastodon::Response::Notification)" do
      notifications.should be_a Array(Mastodon::Response::Notification)
    end
  end

  describe ".notifications(id)" do
    it "Response should be a Mastodon::Response::Notification" do
      notification.should be_a Mastodon::Response::Notification
    end
  end
end
