require "json"
require "./status"

module Mastodon
  module Entities
    class Context

      JSON.mapping({
        ancestors: { type: Array(Entities::Status), nilable: true },
        descendants: { type: Array(Entities::Status), nilable: true },
      })

    end
  end
end
