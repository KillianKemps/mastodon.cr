require "../../spec_helper"

def notifications(max_id = nil, since_id = nil, limit = 15)
  params = HTTP::Params.build do |param|
    param.add "max_id", "#{max_id}" unless max_id.nil?
    param.add "since_id", "#{since_id}" unless since_id.nil?
    param.add "limit", "#{limit}" if limit != 15 && limit <= 30
  end
  query = "?#{params}" unless params.empty?
  stub_get("/api/v1/notifications#{query}", "notifications")
  client.notifications(max_id, since_id, limit)
end

def notification(id)
  stub_get("/api/v1/notifications/#{id}", "notification")
  client.notification(id)
end

def delete_notification(id)
  stub_post_no_return("/api/v1/notifications/dismiss/#{id}")
  client.delete_notification(id)
end

def clear_notifications
  stub_post_no_return("/api/v1/notifications/clear")
  client.clear_notifications
end

describe Mastodon::REST::Client do
  describe ".notifications(max_id, since_id, limit)" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Notification)" do
      notifications().should be_a Mastodon::Collection(Mastodon::Entities::Notification)
    end
  end

  describe ".notification(id)" do
    it "Response should be a Mastodon::Entities::Notification" do
      notification(1).should be_a Mastodon::Entities::Notification
    end
  end

  describe ".delete_notification(id)" do
    it "Response should be no return" do
      delete_notification(1).should be_nil
    end
  end

  describe ".clear_notifications" do
    it "Response should be no return" do
      clear_notifications.should be_nil
    end
  end
end
