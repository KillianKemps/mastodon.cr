require "json"

module Mastodon
  module Entities
    class Tag

      JSON.mapping({
        name: String,
        url: String,
      })

    end
  end
end
