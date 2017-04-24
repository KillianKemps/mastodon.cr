require "http/client"
require "json"

module Mastodon
  module REST
    module Timelines
      TIMELINES_BASE = "/api/v1/timelines"

      def timeline_home(max_id = nil, since_id = nil, limit = DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= 80
        end
        response = get("#{TIMELINES_BASE}/home", params)
        Array(Entities::Status).from_json(response)
      end

      def timeline_public(max_id = nil, since_id = nil, local = false, limit = DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= 80
        end
        response = get("#{TIMELINES_BASE}/public", params)
        Array(Entities::Status).from_json(response)
      end

      def timeline_tag(hashtag, max_id = nil, since_id = nil, local = false, limit = DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= 80
        end
        response = get("#{TIMELINES_BASE}/tag/#{hashtag}", params)
        Array(Entities::Status).from_json(response)
      end
    end
  end
end
