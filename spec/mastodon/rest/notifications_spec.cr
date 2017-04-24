require "../../spec_helper"

def notifications
  stub_get("/api/v1/notifications", "notifications")
  client.notifications
end

def notification(id)
  stub_get("/api/v1/notifications/#{id}", "notification")
  client.notification(id)
end

describe Mastodon::REST::Client do
  describe ".notifications" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Notification)" do
      notifications.should be_a Mastodon::Collection(Mastodon::Entities::Notification)
    end
  end

  describe ".notification(id)" do
    it "Response should be a Mastodon::Entities::Notification" do
      notification(1).should be_a Mastodon::Entities::Notification
    end
  end
end
