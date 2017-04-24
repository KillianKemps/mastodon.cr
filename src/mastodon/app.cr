require "json"

module Mastodon
  class App

    JSON.mapping({
      id: Int32,
      redirect_uri: String,
      client_id: String,
      client_secret: String,
    })

    def_equals id
  end
end
