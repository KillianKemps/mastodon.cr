require "http/client"
require "json"

module Mastodon
  module REST
    module Instances
      private INSTANCES_BASE = "/api/v1/instance"

      def instance
        # Does not require authentication
        response = get("#{INSTANCES_BASE}")
        Entities::Instance.from_json(response)
      end
    end
  end
end
