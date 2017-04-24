require "json"
require "./status"

module Mastodon
  module Response
    class Context

      JSON.mapping({
        ancestors: { type: Array(Response::Status), nilable: true },
        descendants: { type: Array(Response::Status), nilable: true },
      })

    end
  end
end
