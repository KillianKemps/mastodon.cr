require "json"

module Mastodon
  module Response
    class Instance

      JSON.mapping({
        uri: String,
        title: String,
        description: String,
        email: String,
      })

    end
  end
end
