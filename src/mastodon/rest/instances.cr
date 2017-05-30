require "http/client"
require "json"

module Mastodon
  module REST
    module Instances
      def instance
        # Does not require authentication
        response = get("/api/v1/instance")
        Entities::Instance.from_json(response)
      end
    end
  end
end
