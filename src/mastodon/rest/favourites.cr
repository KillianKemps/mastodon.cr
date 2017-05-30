require "http/client"
require "json"

module Mastodon
  module REST
    module Favourites
      def favourites(max_id = nil, since_id = nil, limit = DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= DEFAULT_STATUSES_LIMIT * 2
        end
        response = get("/api/v1/favourites")
        Collection(Entities::Status).from_json(response)
      end
    end
  end
end
