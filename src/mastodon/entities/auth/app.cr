require "json"

module Mastodon
  module Entities
    module Auth
      class App

        JSON.mapping({
          id: Int64,
          redirect_uri: String,
          client_id: String,
          client_secret: String,
        })

        def_equals id
      end
    end
  end
end
