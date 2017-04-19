require "json"

module Mastodon
  module Response
    class Error

      JSON.mapping({
        error: String,
      })

    end
  end
end
