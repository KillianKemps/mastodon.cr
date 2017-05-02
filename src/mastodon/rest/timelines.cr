require "http/client"
require "json"

module Mastodon
  module REST
    module Timelines
      TIMELINES_BASE = "/api/v1/timelines"

      def timeline_home(max_id = nil, since_id = nil, limit = STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != STATUSES_LIMIT && limit <= STATUSES_LIMIT * 2
        end
        response = get("#{TIMELINES_BASE}/home", params)
        Collection(Entities::Status).from_json(response)
      end

      def timeline_public(local = false, max_id = nil, since_id = nil, limit = STATUSES_LIMIT)
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != STATUSES_LIMIT && limit <= STATUSES_LIMIT * 2
        end
        response = get("#{TIMELINES_BASE}/public", params)
        Collection(Entities::Status).from_json(response)
      end

      def timeline_tag(hashtag, local = false, max_id = nil, since_id = nil, limit = STATUSES_LIMIT)
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != STATUSES_LIMIT && limit <= STATUSES_LIMIT * 2
        end
        response = get("#{TIMELINES_BASE}/tag/#{hashtag}", params)
        Collection(Entities::Status).from_json(response)
      end
    end
  end
end
