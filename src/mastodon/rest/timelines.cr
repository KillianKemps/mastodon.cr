require "http/client"
require "json"

module Mastodon
  module REST
    module Timelines
      TIMELINES_BASE = "/api/v1/timelines"

      def timeline_home(limit = Api::DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "limit", "#{limit}" if limit != Api::DEFAULT_STATUSES_LIMIT && limit <= 80
        end
        response = get("#{TIMELINES_BASE}/home", params)
        Array(Mastodon::Response::Status).from_json(response)
      end

      def timeline_public(local = false, limit = Api::DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
          param.add "limit", "#{limit}" if limit != Api::DEFAULT_STATUSES_LIMIT && limit <= 80
        end
        response = get("#{TIMELINES_BASE}/public", params)
        Array(Mastodon::Response::Status).from_json(response)
      end

      def timeline_tag(hashtag, local = false, limit = Api::DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
          param.add "limit", "#{limit}" if limit != Api::DEFAULT_STATUSES_LIMIT && limit <= 80
        end
        response = get("#{TIMELINES_BASE}/tag/#{hashtag}", params)
        Array(Mastodon::Response::Status).from_json(response)
      end
    end
  end
end
