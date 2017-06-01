require "http/client"
require "json"

module Mastodon
  module REST
    module Follows
      private FOLLOWS_BASE = "/api/v1/follows"

      def follows(username)
        response = post("#{FOLLOWS_BASE}", { "uri" => "#{username}" })
        Entities::Account.from_json(response)
      end
    end
  end
end
