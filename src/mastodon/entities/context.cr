require "json"
require "./status"

module Mastodon
  module Entities
    class Context

      JSON.mapping({
        ancestors: Array(Entities::Status),
        descendants: Array(Entities::Status),
      })

    end
  end
end
