require "json"

module Mastodon
  module Entities
    class Instance

      JSON.mapping({
        uri: String,
        title: String,
        description: String,
        email: String,
        version: { type: String, nilable: true },
      })

    end
  end
end
