require "../../spec_helper"

describe Mastodon::REST::Notifications do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#notifications" do
    before do
      stub_get("/api/v1/notifications", "notifications")
    end
    subject { client.notifications }
    it "is a Mastodon::Collection(Mastodon::Entities::Notification)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Notification)
    end
  end

  describe "#notification" do
    before do
      stub_get("/api/v1/notifications/1", "notification")
    end
    subject { client.notification(1) }
    it "is a Mastodon::Entities::Notification" do
      expect(subject).to be_a Mastodon::Entities::Notification
    end
  end

  describe "#delete_notification" do
    before do
      stub_post("/api/v1/notifications/dismiss/1")
    end
    subject { client.delete_notification(1) }
    it "is no return" do
      expect(subject).to be_nil
    end
  end

  describe "#clear_notifications" do
    before do
      stub_post("/api/v1/notifications/clear")
    end
    subject { client.clear_notifications }
    it "is no return" do
      expect(subject).to be_nil
    end
  end
end
