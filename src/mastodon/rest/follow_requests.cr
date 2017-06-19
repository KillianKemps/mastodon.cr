require "http/client"
require "json"

module Mastodon
  module REST
    module FollowRequests
      private FOLLOW_REQUESTS_BASE = "/api/v1/follow_requests"

      def follow_requests(max_id = nil, since_id = nil, limit = DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= DEFAULT_ACCOUNTS_LIMIT * 2
        end
        response = get("#{FOLLOW_REQUESTS_BASE}", params)
        Entities.from_response(response, Collection(Entities::Account))
      end

      def authorize_follow_request(id)
        post("#{FOLLOW_REQUESTS_BASE}/#{id}/authorize")
        nil
      end

      def reject_follow_request(id)
        post("#{FOLLOW_REQUESTS_BASE}/#{id}/reject")
        nil
      end
    end
  end
end
