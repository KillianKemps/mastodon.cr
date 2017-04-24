require "json"

module Mastodon
  module Entities
    class Card

      JSON.mapping({
        url: { type: String, nilable: true },
        title: { type: String, nilable: true },
        description: { type: String, nilable: true },
        image: { type: String, nilable: true },
      })

    end
  end
end
