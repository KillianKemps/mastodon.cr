require "http/client"
require "json"

module Mastodon
  module REST
    module Search
      def search(query, resolve = false)
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "q", "#{query}"
          param.add "resolve", "true" if resolve
        end
        response = get("/api/v1/search", params)
        Entities::Results.from_json(response)
      end
    end
  end
end
