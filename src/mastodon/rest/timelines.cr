require "http/client"
require "json"

module Mastodon
  module REST
    module Timelines
      TIMELINES_BASE = "/api/v1/timelines"

      def timeline_home
        response = get("#{TIMELINES_BASE}/home")
        Array(Mastodon::Response::Status).from_json(response)
      end

      def timeline_public(local = false)
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
        end
        response = get("#{TIMELINES_BASE}/public", params)
        Array(Mastodon::Response::Status).from_json(response)
      end

      def timeline_tag(hashtag, local = false)
        params = HTTP::Params.build do |param|
          param.add "local", "" if local
        end
        response = get("#{TIMELINES_BASE}/tag/#{hashtag}", params)
        Array(Mastodon::Response::Status).from_json(response)
      end
    end
  end
end
