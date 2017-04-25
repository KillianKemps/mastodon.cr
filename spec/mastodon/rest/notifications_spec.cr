require "../../spec_helper"

describe Mastodon::REST::Notifications do
  describe ".notifications(max_id, since_id, limit)" do
    before do
      stub_get("/api/v1/notifications", "notifications")
    end
    subject { client.notifications }
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Notification)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Notification)
    end
  end

  describe ".notification(id)" do
    before do
      stub_get("/api/v1/notifications/1", "notification")
    end
    subject { client.notification(1) }
    it "Response should be a Mastodon::Entities::Notification" do
      expect(subject).to be_a Mastodon::Entities::Notification
    end
  end

  describe ".delete_notification(id)" do
    before do
      stub_post_no_return("/api/v1/notifications/dismiss/1")
    end
    subject { client.delete_notification(1) }
    it "Response should be no return" do
      expect(subject).to be_nil
    end
  end

  describe ".clear_notifications" do
    before do
      stub_post_no_return("/api/v1/notifications/clear")
    end
    subject { client.clear_notifications }
    it "Response should be no return" do
      expect(subject).to be_nil
    end
  end
end
