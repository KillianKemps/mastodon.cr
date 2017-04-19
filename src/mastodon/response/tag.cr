require "json"

module Mastodon
  module Response
    class Tag

      JSON.mapping({
        name: String,
        url: String,
      })

    end
  end
end
