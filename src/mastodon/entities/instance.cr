require "json"

module Mastodon
  module Entities
    class Instance

      JSON.mapping({
        uri: String,
        title: String,
        description: String,
        email: String,
        version: String,
      })

    end
  end
end
