require "http/client"
require "json"

module Mastodon
  module REST
    module Follows
      def follows(username)
        response = post("/api/v1/follows", { "uri" => "#{username}" })
        Entities::Account.from_json(response)
      end
    end
  end
end
