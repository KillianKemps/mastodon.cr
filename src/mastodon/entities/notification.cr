require "json"
require "./account"
require "./status"

module Mastodon
  module Entities
    class Notification

      JSON.mapping({
        id: Int64,
        type: String, # "mention", "reblog", "favourite", "follow"
        created_at: { type: Time, converter: Time::Format.new("%Y-%m-%dT%T") },
        account: Entities::Account,
        status: { type: Entities::Status, nilable: true }
      })

    end
  end
end
