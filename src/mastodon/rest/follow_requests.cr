require "http/client"
require "json"

module Mastodon
  module REST
    module FollowRequests
      def follow_requests(max_id = nil, since_id = nil, limit = DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= DEFAULT_ACCOUNTS_LIMIT * 2
        end
        response = get("/api/v1/follow_requests", params)
        Collection(Entities::Account).from_json(response)
      end

      def authorize_follow_request(id)
        post("/api/v1/follow_requests/#{id}/authorize")
        nil
      end

      def reject_follow_request(id)
        post("/api/v1/follow_requests/#{id}/reject")
        nil
      end
    end
  end
end
