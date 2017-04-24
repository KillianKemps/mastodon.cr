require "json"

module Mastodon
  module Entities
    class Error

      JSON.mapping({
        error: String,
      })

    end
  end
end
