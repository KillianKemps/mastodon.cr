require "json"
require "./account"
require "./status"

module Mastodon
  module Response
    class Notification

      JSON.mapping({
        id: Int32,
        type: String,
        created_at: { type: Time, converter: Time::Format.new("%Y-%m-%dT%T") },
        account: Mastodon::Response::Account,
        status: { type: Mastodon::Response::Status, nilable: true }
      })

    end
  end
end
