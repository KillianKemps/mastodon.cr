require "json"
require "./status"

module Mastodon
  module Response
    class Context

      JSON.mapping({
        ancestors: { type: Array(Mastodon::Response::Status), nilable: true },
        descendants: { type: Array(Mastodon::Response::Status), nilable: true },
      })

    end
  end
end
