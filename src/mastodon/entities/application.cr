require "json"

module Mastodon
  module Entities
    class Application

      JSON.mapping({
        name: String,
        website: { type: String, nilable: true },
      })

    end
  end
end
