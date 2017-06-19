require "http/client"
require "json"

module Mastodon
  module REST
    module Notifications
      private NOTIFICATIONS_BASE = "/api/v1/notifications"

      def notifications(max_id = nil, since_id = nil, limit = DEFAULT_NOTIFICATIONS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_NOTIFICATIONS_LIMIT && limit <= DEFAULT_NOTIFICATIONS_LIMIT * 2
        end
        response = get("#{NOTIFICATIONS_BASE}", params)
        Entities.from_response(response, Collection(Entities::Notification))
      end

      def notification(id)
        response = get("#{NOTIFICATIONS_BASE}/#{id}")
        Entities.from_response(response, Entities::Notification)
      end

      def delete_notification(id)
        post("#{NOTIFICATIONS_BASE}/dismiss/#{id}")
        nil
      end

      def clear_notifications
        post("#{NOTIFICATIONS_BASE}/clear")
        nil
      end

    end
  end
end
