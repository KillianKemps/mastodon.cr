require "json"
require "./account"
require "./status"

module Mastodon
  module Entities
    class Results

      JSON.mapping({
        accounts: { type: Array(Entities::Account), nilable: true },
        statuses: { type: Array(Entities::Status), nilable: true },
        hashtags: { type: Array(String), nilable: true },
      })

    end
  end
end
