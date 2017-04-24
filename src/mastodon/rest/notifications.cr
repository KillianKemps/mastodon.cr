require "http/client"
require "json"

module Mastodon
  module REST
    module Notifications
      NOTIFICATIONS_BASE = "/api/v1/notifications"

      def notifications
        response = get("#{NOTIFICATIONS_BASE}")
        Collection(Entities::Notification).from_json(response)
      end

      def notification(id)
        response = get("#{NOTIFICATIONS_BASE}/#{id}")
        Entities::Notification.from_json(response)
      end

      def delete_notification(id)
        post("#{NOTIFICATIONS_BASE}/dismiss/#{id}")
      end

      def clear_notifications
        post("#{NOTIFICATIONS_BASE}/clear")
      end

    end
  end
end
