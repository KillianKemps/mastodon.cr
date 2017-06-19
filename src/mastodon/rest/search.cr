require "http/client"
require "json"

module Mastodon
  module REST
    module Search
      private SEARCH_BASE = "/api/v1/search"

      def search(query, resolve = false)
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "q", "#{query}"
          param.add "resolve", "true" if resolve
        end
        response = get("#{SEARCH_BASE}", params)
        Entities.from_response(response, Entities::Results)
      end
    end
  end
end
