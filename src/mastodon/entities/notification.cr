require "json"
require "./account"
require "./status"

module Mastodon
  module Entities
    class Notification

      JSON.mapping({
        id: Int32,
        type: String,
        created_at: { type: Time, converter: Time::Format.new("%Y-%m-%dT%T") },
        account: Entities::Account,
        status: { type: Entities::Status, nilable: true }
      })

    end
  end
end
