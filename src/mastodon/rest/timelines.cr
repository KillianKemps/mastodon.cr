require "http/client"
require "json"

module Mastodon
  module REST
    module Timelines
      private TIMELINES_BASE = "/api/v1/timelines"

      def timeline_home(max_id = nil, since_id = nil, limit = DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= DEFAULT_STATUSES_LIMIT * 2
        end
        response = get("#{TIMELINES_BASE}/home", params)
        Entities.from_response(response, Collection(Entities::Status))
      end

      def timeline_public(local = false, max_id = nil, since_id = nil, limit = DEFAULT_STATUSES_LIMIT)
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= DEFAULT_STATUSES_LIMIT * 2
        end
        response = get("#{TIMELINES_BASE}/public", params)
        Entities.from_response(response, Collection(Entities::Status))
      end

      def timeline_tag(hashtag, local = false, max_id = nil, since_id = nil, limit = DEFAULT_STATUSES_LIMIT)
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= DEFAULT_STATUSES_LIMIT * 2
        end
        response = get("#{TIMELINES_BASE}/tag/#{hashtag}", params)
        Entities.from_response(response, Collection(Entities::Status))
      end
    end
  end
end
