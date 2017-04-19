require "json"

module Mastodon
  module Response
    class Mention

      JSON.mapping({
        url: String,
        username: String,
        acct: String,
        id: Int32,
      })

    end
  end
end
