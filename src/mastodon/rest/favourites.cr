require "http/client"
require "json"

module Mastodon
  module REST
    module Favourites
      private FAVOURITES_BASE = "/api/v1/favourites"

      def favourites(max_id = nil, since_id = nil, limit = DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= DEFAULT_STATUSES_LIMIT * 2
        end
        response = get("#{FAVOURITES_BASE}")
        Entities.from_response(response, Collection(Entities::Status))
      end
    end
  end
end
