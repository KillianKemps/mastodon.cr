require "json"

module Mastodon
  module Entities
    module Auth
      class AccessToken

        JSON.mapping({
          access_token: String,
          token_type: String,
          scope: String,
          created_at: Int64,
        })

      end
    end
  end
end
